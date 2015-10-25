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
== Java Class �t�@�C�����̃l�C�e�B�u���\�b�h�� template �����

- rjn/ �ȉ��ɍ��
- ���łɂ�������o�b�N�A�b�v���Ƃ�
- java.lang.Object => RJN_java_lang_Object �Ƃ����N���X���ɂȂ�
- java.lang.Object => rjn/RJN_java_lang_Object.rb �Ƃ����t�@�C�����ɂȂ�

== native method ��`�N���X�̎d�l

=== instance method

- arg[0],arg[1],... �ŁAmethod �̈����� n �ԖڂɃA�N�Z�X�ł���
- ������ this ������
-- this['prop'] �� field �ɃA�N�Z�X�ł���
-- this.owner['prop'] �� static field �ɃA�N�Z�X�ł���

=== static method

- arg[0],arg[1],... �ŁAmethod �̈����� n �ԖڂɃA�N�Z�X�ł���
- ������ jclass ������
-- jclass['prop'] �� static field

=== ����

* java.lang.String �̃I�u�W�F�N�g jstr �� jstr.to_s �́A$RJ_KCODE �Ŏ����ꂽ�����R�[�h�̕����񂪓����Ă���(�͂�)

* �����̔ԍ��ł����Aint , long , int �̏ꍇ�Aarg[0],arg[1],arg[3] �ɂȂ�܂��B
  long , double �ɂ�����������������܂��B
  �����������̂Ȃ�ł��B�Ȃ񂩂�����͖������̂��B

* ���Ԃ́A�^�C�v�Ŏ����ł����Ĕ��f����
�itemplate �ɁA���f�p�̂��̂��܂߂܂��j
  
== ��

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
      # ����
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
        # �����̌^������
        op.puts '    case method.mdesc'
        m.each{|mm|
          op.puts "    # #{mm.decode_name_and_type}"
          op.puts "    when '#{mm.mdesc}'"
          op.puts
        }
        op.puts ''
        op.puts '    end'
      else
        # ���
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

# native �̐���\��
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
