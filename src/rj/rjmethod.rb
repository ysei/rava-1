#!/usr/bin/ruby
# @file   rjmethod.rb
# @author K.S.
#
# $Date: 2002/12/02 00:35:59 $
# $Id: rjmethod.rb,v 1.5 2002/12/02 00:35:59 ko1 Exp $
#
# Create : K.S. 02/10/09 06:10:01
#
#
#
#
require 'rjopcodeinfo'
require 'rjmethod_compiler'

class RJMethod
  include RJOpcodeinfo
  
  attr_reader :mname
  attr_reader :mdesc
  attr_reader :code
  attr_reader :max_local
  attr_reader :max_stack
  attr_reader :arg_size
  attr_reader :ret_size
  attr_reader :owner
  attr_reader :ruby_expr
  attr_reader :code_length
  
  
  def initialize owner,cls
    @cls = cls
    @owner = owner
    @exception_table = []
    @code_length = 0
    @ruby_expr = nil
    @compile_border = 1 # num 回このメソッドが呼ばれたらコンパイルか
    load
  end
  
  
  def is_static?
    @access_flag & 0x0008 != 0
  end
  def is_native?
    @access_flag & 0x0100 != 0
  end

  def invoke_native args,th
    if @owner.native_support == nil
      puts "can't find that native method support class."
      puts "plz write this native support class. jrnative.rb will helps this."
      puts "ex) ruby rjnative.rb #{@owner.this_class}"
      puts ''
      raise
    end

    if self.is_static?
      # jclass,arg,method,thread
      @owner.native_support.__send__ @mname,@owner,args,self,th
    else
      # this,arg,method,thread
      @owner.native_support.__send__ @mname,args[0],args[1 .. -1],self,th
    end

  end
  
  def load
    @access_flag = u2
    @mname = @owner.const[u2]
    @mdesc = @owner.const[u2]

    @arg_size  = calc_arg_size
    @ret_size  = calc_ret_size
    
    @max_local = @arg_size # native では最低 arg_size
    @max_stack = 2         # native では最低 2
    
    attributes_count = u2
    attributes_count.times{
      load_attributes
    }
    
  end

  def invoke
    return
    if is_native?
      return
    end
    @compile_border -= 1
    if @compile_border == 0 and @mname == 'speed_test'
      @ruby_expr = RJMethodCompiler.compile self
      @ruby_expr.each{|ruby_expr_key,ruby_expr_val|
        @code[ruby_expr_key] = 0xfe
        fn = @mname + '_compiled'
        
        # puts '==> ' + ruby_expr_key.to_s , ruby_expr_val

        RJThread.module_eval "
        def #{fn}
          #{ruby_expr_val}
        end
        "
        @ruby_expr[ruby_expr_key] = RJThread.instance_method fn
      }
      @compile_border = -1 # とりあえず、一度しかしない
    end
  end

  def load_attributes
    attr_name = @owner.const[u2]
    
    attribute_length = u4
    if attr_name == 'Code'
      @max_stack   = u2
      @max_local   = u2
      @code_length = u4
      @code = @cls.read @code_length
      exception_table_length = u2
      exception_table_length.times{
        start_pc   = u2
        end_pc     = u2
        handler_pc = u2
        catch_type = u2
        @exception_table << [start_pc,end_pc,handler_pc,@owner.const[catch_type]]
      }
      attributes_count = u2
      attributes_count.times{
        attr_name = u2
        attr_length = u4
        @cls.read attr_length
        # raise 'not supported'
      }
    else
      @cls.read attribute_length
    end
  end

  def search_exception_handler e,pc
    @exception_table.each{|et|
      if et[0] < pc && pc <= et[1]
        if e.is_kind_of(et[3])
          return et[2]
        end
      end
    }
    nil
  end
  
  def to_s
    "RJMethod . #{@mname} : #{@mdesc} @ #{@owner.this_class}"
  end
  
  def verbose
    ret = 
#   "name : #{@mname}\n" + 
#   "type : #{@mdesc}\n" +
    "     : #{decode_name_and_type}\n" + 
    "stack: #{@max_stack}\n" +
    "local: #{@max_local}\n" +
    "len  : #{@code_length}\n"+
    "code :\n"
    if is_native?
      ret +=
      "     : ==> native method\n"
      return ret
    end

    
    i = 0
    while i<@code_length
      c = @code[i]
      len = get_opcode_length c
      if len == 0
        len += 1
        len += (4 - (i+1)%4) % 4
        if c == 0xab # lookupswitch
          len += 4
          pairs = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
          (@code[i+len+2] << 8)+ (@code[i+len+3])
          len += 4 + pairs * 2
          
        else # tableswitch
          len += 4
          low  = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
          (@code[i+len+2] << 8)+ (@code[i+len+3])
          len += 4
          high = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
          (@code[i+len+2] << 8)+ (@code[i+len+3])
          len += 4

          len += 4 + (high - low + 1) * 4
        end
      end
      opt = get_opcode_arg c
      case opt
      when 'cc'
        ce  = @owner.const[(@code[i+1] << 8) + @code[i+2]]
        if(ce.kind_of? Array)
          # [class,name,type]
          if ce[2] =~ /\((.*)\)(.+)/
            # method
            pars = $1
            retv = $2
            ce = decode_types(retv) + ' ' + ce[0].gsub('/','.') + '.' + ce[1] +
                 '(' + decode_types(pars) + ')'
          else
            # field
            ce = decode_types(ce[2]) + ' ' + ce[0].gsub('/','.') + '.' + ce[1]
          end
        end
        opt = ce.to_s
      when 'ii'
        opt = @code[i+1,2].reverse.unpack 's'
      when '1'
        opt = @code[i+1].to_i
      end
      opt = "<#{opt}>" if opt.to_s.length > 0
      ret += "#{sprintf("%4d",i)}\t#{OpcodeName[c]} #{opt}\n"
      i+=len
    end
    if @exception_table.size > 0
      ret += "   from   to  target type\n"
      @exception_table.each{|et|
        ret += " %5d %5d %5d   %s\n" % et
      }
    end
    ret
  end

  def const idx
    @owner.const[idx]
  end

  def calc_arg_size
    i = 0
    @mdesc =~ /\((.*)\)/
    ret = 0
    lflg = false
    $1.split('').each{|c|
      if lflg
        if c == ';'
          lflg = false
        end
        next
      end
      
      case c
      when 'B','C','F','I','S','Z'
        ret += 1
      when 'D','J'
        ret += 2
      when 'L'
        ret += 1 ; lflg = true
      end
      # [ は見なくていいのかって？
      # いいんじゃないの？　無視しちゃって
    }
    ret + (is_static? ? 0 : 1)
  end

  def calc_ret_size
    i = 0
    ret = 0
    flg = false
    @mdesc =~ /\(.*\)(.)/
    case $1
    when 'B','C','F','I','S','Z','L','['
      return 1
    when 'J'
      return 2
    when 'D'
      return 3
    end
    return 0 # void
  end
  
  TypeMean = {
    'B' => 'byte',
    'C' => 'char',
    'D' => 'double',
    'F' => 'float',
    'I' => 'int',
    'J' => 'long',
    'S' => 'short',
    'Z' => 'boolean',
    'V' => 'void',
  }

  def decode_type str
    return if str == nil
    case str[0].chr
    when '['
      str =~ /^(\[+)(.+)/
      al = $1.length
      s = decode_type($2)
      [s[0] + '[]' * al , s[1] + al]
    when 'L'
      str =~ /^L([^;]+);/
      s = $1.gsub('/','.')
      [s , 2+s.length]
    else
      [TypeMean[str[0].chr],1]
    end
  end

  def decode_types str
    ret = []
    n = 0
    while n < str.length
      s = decode_type str[n .. -1]
      ret << s[0]
      n   += s[1]
    end
    ret.join(',')
  end

  def decode_name_and_type
    @mdesc =~ /\((.*)\)(.+)/
    pars = $1
    retv = $2

    decode_types(retv) + ' ' + @mname + '(' + decode_types(pars) + ')'
  end

  def get_opcode_length_variable i
    c = @code[i]
    len  = 0
    len += 1
    len += (4 - (i+1)%4) % 4
    if c == 0xab # lookupswitch
      len += 4
      pairs = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
      (@code[i+len+2] << 8)+ (@code[i+len+3])
      len += 4 + pairs * 2
      
    else # tableswitch
      len += 4
      low  = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
      (@code[i+len+2] << 8)+ (@code[i+len+3])
      len += 4
      high = (@code[i+len] << 24) + (@code[i+len+1] << 16) +
      (@code[i+len+2] << 8)+ (@code[i+len+3])
      len += 4
      
      len += 4 + (high - low + 1) * 4
    end
  end

  
  # read helper
private
  def u4
    ((@cls.read 4).unpack 'N')[0]
  end
  def u2
    ((@cls.read 2).unpack 'n')[0]
  end
  def u1
    ((@cls.read 1).unpack 'C')[0]
  end
  
end


if $0 == __FILE__
  require 'rjclass'
  fn = ARGV[0] || 'test'
  fn.gsub!('\.','/')
  fn += '.class'
  $RJ_KCODE = Kconv::SJIS
  
  if (!fn); fn = 'test.class' ; end
    
  open(fn,'rb'){|f|
    c = RJClass.new f
    # puts c.verbose
    m = c.get_static_method 'speed_test','()V'
    # puts m.jit_verbose
  }
end




