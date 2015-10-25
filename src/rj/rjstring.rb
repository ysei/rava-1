#!/usr/bin/ruby
# @file   rjstring.rb
# @author K.S.
#
# $Date: 2002/11/27 08:55:26 $
# $Id: rjstring.rb,v 1.2 2002/11/27 08:55:26 ko1 Exp $
#
# Create : K.S. 02/11/16 06:43:42
#
# java.lang.String を表現するクラス
#
#

=begin

= RJStringInstance

java.lang.String を表現する

文字列は utf-16 で保持するらしい。どこに載っていたのかな・・・？

コンスタントプールは、utf-8 で保持するので、面倒くさい。

=end


require 'kconv'
require 'uconv'
require 'rjinstance'
require 'rjclassmanager'

class RJStringInstance < RJInstance
  JStringClass = RJClassManager.instance.get('java.lang.String')

  # utf8 をそのまま入れるなら、is_utf8 => true
  def initialize str = '' , is_utf8 = false
    super JStringClass
    
    set_string str,is_utf8
  end

  def get_string
    if @fields.has_key? 'value'
      Kconv.kconv Uconv.u16tosjis(self['value'][0,self['count']].pack 'S*') , $RJ_KCODE
    else
      raise 'this instance is not string class.'
    end
  end

  # utf8 をそのまま入れるなら、is_utf8 => true
  def set_string str , is_utf8 = false
    if is_utf8 == false
      str = Uconv.sjistou16(str.tosjis)
    else
      str = Uconv.u8tou16 str
    end
    
    if @fields.has_key? 'value'
      utf16array = str.unpack 'S*'
      @fields['value'] = utf16array
      @fields['count'] = utf16array.length
    else
      raise 'this instance is not string class.'
    end
  end
  
  def to_s
    get_string
  end
end

if $0 == __FILE__
  require 'runit/testcase'
  require 'runit/cui/testrunner'
  
  class TestUnit < RUNIT::TestCase
    def test_string_new
      $RJ_KCODE = Kconv::SJIS
      
      org = '表示する？'
      str = RJStringInstance.new org

      assert_equal(org , str.to_s)
      assert_equal(org.length/2 , str['count'])
    end
  end
  RUNIT::CUI::TestRunner.run(TestUnit.suite)
end
