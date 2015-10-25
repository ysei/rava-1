#!/usr/bin/ruby
# @file   rava.rb
# @author K.S.
#
# $Date: 2002/12/02 00:35:59 $
# $Id: rava.rb,v 1.3 2002/12/02 00:35:59 ko1 Exp $
#
# Create : K.S. 02/10/12 18:18:31
#
#
# Rava
# ( rava かぁ・・・ )


# 必要なのも、少ないねぇ・・・
require 'rjthreadmanager'
require 'rjclassmanager'
require 'kconv'

$RJ_KCODE = Kconv::SJIS

##############################################
# start

tm = RJThreadManager.instance
cm = RJClassManager .instance

lc = ARGV[0] || 'test'

# puts "load #{lc}"
lc.gsub!('\.','/')

m = cm.load lc           # main なクラスをロードする
t = tm.create            # 新しいスレッドを用意
t.set_main m,ARGV[1..-1] # main を起動する準備をする

t.kick                   # そのスレッドを起動（うへえ）

# なんか簡単だ（笑）


# 最後のがなくなるまでストップ
Thread.stop


