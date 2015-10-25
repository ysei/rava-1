#!/usr/bin/ruby
# @file   rjinstance.rb
# @author K.S.
#
# $Date: 2002/11/16 19:25:25 $
# $Id: rjinstance.rb,v 1.2 2002/11/16 19:25:25 ko1 Exp $
#
# Create : K.S. 02/10/13 01:41:42
#
#
# new されたインスタンスを表現
#
# 主に field 管理

class RJInstance
  attr_reader :owner
  
  def initialize own
    @owner   = own
    @fields  = {}
    set_fields own
  end

  def to_s
    "instance of #{@owner.to_s}"
  end

  # accessor
  def []=(prop,val)
    if @fields.has_key? prop
      @fields[prop] = val
    else
      raise "#{self.to_s} doesn't have such field : #{prop}"
    end
  end
  def [](prop)
    if @fields.has_key? prop
      @fields[prop]
    else
      raise "#{self.to_s} doesn't have such field : #{prop}"
    end
  end

  # このインスタンスが、str であるか、str を親として持つか
  def is_kind_of str
    @owner.is_kind_of str
  end

  def jtype
    @owner.this_class
  end

private

  def set_fields cls
    # puts "#{cls.this_class}"
    cls.jfields.each{|k,v|
      # puts "#** #{k} = #{v.join ','},#{sprintf("%08x",v[0])}"
      if (v[0] & 0x0008) == 0
        @fields[k] = 0
      end
    }
    if cls.super
      set_fields cls.super
    end
  end
  
end

class RJArrayInstance < Array
  def to_s
    ret = "Array(#{self.size}) : ["
    10.times{|i|
      if self.size < i
        break
      end
      ret += self[i].to_s
      ret += ','
    }
    ret + '...]'
  end
  def verbose
    "Array(#{self.size}) : [" +
    self.join(',') + ']'
  end
end

