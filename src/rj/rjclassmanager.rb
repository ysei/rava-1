#!/usr/bin/ruby
# @file   rjclassmanager.rb
# @author K.S.
#
# $Date: 2002/11/27 08:55:26 $
# $Id: rjclassmanager.rb,v 1.3 2002/11/27 08:55:26 ko1 Exp $
#
# Create : K.S. 02/10/12 15:47:38
#
# class manager
#
#

require 'rjclass'
require 'rjthread'
require 'rjnative'
require 'rjout'

require 'singleton'

class RJClassManager
  include Singleton
  include RJOut
  
  def initialize
    @jclasses = {}
  end

  # class をロード
  def load name
    loout " load class --> #{name}"
    fn = name + '.class'    #         => hoe/hue.class
    c = nil
    open(fn,'rb'){|f|
      c = RJClass.new f
    }
    @jclasses[name] = c

    # super class の設定
    if c.super_class
      c.set_super(get c.super_class)
    end

    # RJN* があれば、ロードしておく
    class_name = 'RJN_' + c.this_class.gsub('_','__').gsub('/','_')
    file_name  = 'rjn/' + class_name + '.rb'
    if FileTest.exist? file_name
      Kernel.load file_name
      c.set_native_support_class eval "#{class_name}.new"
    end
    
    # clinit があったら
    # ...
    if c.has_clinit?
      clinit_thread = RJThread.new
      clinit_thread.set_clinit c
      clinit_thread.interpret # ここで全部やってしまう
    end

    loout " load finish --> #{name}"
    c
  end

  # class をゲットする。無ければロードする
  def get name
    # puts "load name : #{name}"
    name.gsub!('\.','/') # hoe.hue => hoe/hue
    if @jclasses.key? name
      @jclasses[name]
    else
      load name
    end
  end
  
end

require 'rjstring'
