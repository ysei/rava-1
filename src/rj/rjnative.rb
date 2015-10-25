#!/usr/bin/ruby
# @file   rjnative.rb
# @author K.S.
#
# $Date: 2002/12/08 05:04:38 $
# $Id: rjnative.rb,v 1.3 2002/12/08 05:04:38 ko1 Exp $
#
# Create : K.S. 02/10/13 18:00:29
#
# Native method definission
#

class RJNative

end


=begin
== Java Class ファイル中のネイティブメソッドの template を作る

- rjn/ 以下に作る
- すでにあったらバックアップをとる
- java.lang.Object => RJN_java_lang_Object というクラス名になる
- java.lang.Object => rjn/RJN_java_lang_Object.rb というファイル名になる

== native method 定義クラスの仕様

=== instance method

- arg[0],arg[1],... で、method の引数の n 番目にアクセスできる
- 引数に this を持つ
-- this['prop'] で field にアクセスできる
-- this.owner['prop'] で static field にアクセスできる

=== static method

- arg[0],arg[1],... で、method の引数の n 番目にアクセスできる
- 引数に jclass を持つ
-- jclass['prop'] で static field

=== 注意

* java.lang.String のオブジェクト jstr の jstr.to_s は、$RJ_KCODE で示された漢字コードの文字列が入っている(はず)

* 引数の番号ですが、int , long , int の場合、arg[0],arg[1],arg[3] になります。
  long , double にそういう制限があります。
  そういうものなんです。なんかいい手は無いものか。

* 多態は、タイプで自分でかえて判断する
（template に、判断用のものを含めます）
  
== 例

=end
if __FILE__ == $0
  require 'rjclass'
def make_rjn_template fn
  c = nil

  open(fn,'rb'){|f|
    c = RJClass.new f
  }

  natives = {} # hash
  c.native_methods.each{|m|
    if natives.has_key? m.mname
      # 多態
      natives[m.mname] = natives[m.mname] << m
    else
      natives[m.mname] = [m]
    end
  }
  if natives.size == 0
    return
  end

  class_name = 'RJN_' + c.this_class.gsub('_','__').gsub('/','_')
  file_name  = 'rjn/' + class_name + '.rb'

  # save backup
  if(FileTest.exist?(file_name))
    n = 0
    file_name_to = nil
    loop{
      n += 1
      file_name_to = file_name + '.' + n.to_s
      next if FileTest.exist?(file_name_to)
      break
    }
    File.rename(file_name,file_name_to)
  end
  
  open(file_name , 'w'){|op|
    op.puts "class #{class_name} < RJNative"
    op.puts ''
    natives.each{|n,m|
      m.each{|em|
        op.puts "  # #{em.decode_name_and_type}"
      }
      unless m[0].is_static?
        # instance method
        op.puts "  def #{n} this,arg,method,thread"
      else
        # static method
        op.puts "  def #{n} jclass,arg,method,thread"
      end
      if m.size > 1
        # 複数の型を持つ
        op.puts '    case method.mdesc'
        m.each{|mm|
          op.puts "    # #{mm.decode_name_and_type}"
          op.puts "    when '#{mm.mdesc}'"
          op.puts
        }
        op.puts ''
        op.puts '    end'
      else
        # 一つ
        # op.puts "    # #{m[0].mdesc}"
        op.puts ''
      end

      op.puts "    raise 'unimplemented native method : #{n} @ #{c.this_class}'"
      op.puts "  end"
      op.puts ''
    }
    op.puts "end"
  }
end

# native の雛を表示
if ARGV.size == 0
  make_rjn_template 'test.class'
else
  ARGV.each{|fn|
    fn.gsub!(/\.class$/,'')
    fn.gsub!('\.','/')
    fn += '.class'

    unless FileTest.file? fn
      next
    end

    puts fn

    make_rjn_template fn
  }
end

end
