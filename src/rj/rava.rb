#!/usr/bin/ruby
# @file   rava.rb
# @author K.S.
#
# $Date: 2002/10/14 13:59:49 $
# $Id: rava.rb,v 1.1 2002/10/14 13:59:49 ko1 Exp $
#
# Create : K.S. 02/10/12 18:18:31
#
#
# Rava
# ( rava �����E�E�E )


# �K�v�Ȃ̂��A���Ȃ��˂��E�E�E
require 'rjthreadmanager'
require 'rjclassmanager'

##############################################
# start

tm = RJThreadManager.instance
cm = RJClassManager .instance

m = cm.load ARGV[0]      # main �ȃN���X�����[�h����
t = tm.create            # �V�����X���b�h��p��
t.set_main m,ARGV[1..-1] # main ���N�����鏀��������

t.kick                   # ���̃X���b�h���N���i���ւ��j

# �Ȃ񂩊ȒP���i�΁j


# �Ō�̂��Ȃ��Ȃ�܂ŃX�g�b�v
Thread.stop


