#!/usr/bin/ruby
# @file   rjmethod_compiler.rb
# @author K.S.
#
# $Date: 2002/12/02 00:35:59 $
# $Id: rjmethod_compiler.rb,v 1.1 2002/12/02 00:35:59 ko1 Exp $
#
# Create : K.S. 02/12/02 01:09:52
#
#
# Java のbytecodeを Ruby ソースへコンパイルする
#
require 'rjopcodeinfo'

class RJMethodCompiler
  include RJOpcodeinfo
  
  # read op impl from src
  def RJMethodCompiler.read_op_impl
    @@op_impl = {}
    open 'rjthread_op_impl.rb' do |f|
      mn = nil
      fn = ''
      while line = f.gets
        if line =~ Regexp.new('^  def (.+)')
          mn = $1
        elsif line =~ Regexp.new('^  end')
          @@op_impl[mn] = fn
          mn = nil
          fn = ''
        elsif mn != nil
          fn << line
        end
      end
    end
    # @@op_impl.each{|k,v| puts k + '=============='; puts v}
  end
  # read_op_impl
  
  def RJMethodCompiler.compile m
    if m.is_native?
      raise 'this is native method'
    end
    ret = {}
    ruby_expr = ''
    
    i = 0
    st= 0
    pt= 0
    operand = []
    use_local = Array.new(m.max_local,false)

    # code length
    while i < m.code_length
      c = m.code[i]
      len = m.get_opcode_length c
      len = m.get_opcode_length_variable i if len == 0
      nm  = OpcodeName[c]
      ruby_expr << " # -- #{nm}\n"
      case nm
      when 'lconst_0'
        operand.push 0
        pt += 1
      when 'lconst_1'
        operand.push '1'
        pt += 1
      when 'lload_0'
        operand.push 'l0'
        use_local[0] = true
        pt += 1
      when 'ladd'
        operand.push "#{operand.pop} + #{operand.pop}"
        pt += 1
      when 'lstore_0'
        ruby_expr << "l0 = #{operand.pop} # optimized\n"
        # ruby_expr << "@pc += #{pt+1}\n"
        use_local[0] = true
        #pt = 0
        pt += 1
      when 'iload_2'
        operand.push 'l2'
        use_local[2] = true
        pt += 1
      when 'iinc'
        ruby_expr << "l2 += 1\n"
        pt += 3
      when 'bipush'
        v = m.code[i+1]
        operand.push(((v & 0x80) != 0)? ((v & 0x7f) - 128) : v)
        pt += 2
      when 'ldc'
        operand.push m.owner.const[m.code[i+1].to_i]
        pt += 2
      when 'if_icmplt'
        v2 = operand.pop
        v1 = operand.pop
        jmp = (m.code[i+1,2].reverse.unpack 's')[0]
        
        ruby_expr << "
        if (#{v1}) < (#{v2})
          @pc += #{pt+jmp}
        else
          @pc += #{3+pt}
        end
        "
      when 'goto'
        ruby_expr << "
        @pc += #{pt}
        @pc += s2
        "
      else
        ruby_expr << @@op_impl['op_' + nm]
      end
      
      i+=len

      if nm =~ /if|goto|return|throw/
        if i - st > 4 # あまり短い奴は、採用しない
          if nm =~ /if/ and st == (m.code[i+1-len,2].reverse.unpack 's')[0] + i - len
            ruby_expr = "while true\n" + ruby_expr + "break if @pc == #{i} ; end\n"
          end
          use_local.each_with_index{|e,n|
            if e
              ruby_expr = "l#{n} = local(#{n})\n" + ruby_expr + "local_set(#{n},l#{n})\n"
            end
          }
          ret[st] = ruby_expr
          ruby_expr = ''
          st = i
          pt = 0
        end
      end
    end
    ret
  end

end



