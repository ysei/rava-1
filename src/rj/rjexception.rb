#!/usr/bin/ruby
# @file   rjexception.rb
# @author K.S.
#
# $Date: 2002/11/16 19:25:25 $
# $Id: rjexception.rb,v 1.2 2002/11/16 19:25:25 ko1 Exp $
#
# Create : K.S. 02/10/13 14:36:56
#
# exception ��`
#
#


class RJException < Exception
  # ���ɂȂɂ��E�E�E
end

# �X���b�h�I������O
class RJExceptionFinishThread < RJException
  # ...
end

# athrow �ŗ�O
class RJAthrowException < RJException
  attr_reader :eobj
  def initialize e
    @eobj = e
  end
  # ...
end



