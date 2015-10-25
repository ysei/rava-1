class RJN_java_lang_StrictMath < RJNative

  # double rint(double)
  def rint jclass,arg,method,thread

    raise 'unimplemented native method : rint @ java/lang/StrictMath'
  end

  # double sqrt(double)
  def sqrt jclass,arg,method,thread

    raise 'unimplemented native method : sqrt @ java/lang/StrictMath'
  end

  # double tan(double)
  def tan jclass,arg,method,thread

    raise 'unimplemented native method : tan @ java/lang/StrictMath'
  end

  # double sin(double)
  def sin jclass,arg,method,thread
    Math.sin arg[0]
    # raise 'unimplemented native method : sin @ java/lang/StrictMath'
  end

  # double pow(double,double)
  def pow jclass,arg,method,thread

    raise 'unimplemented native method : pow @ java/lang/StrictMath'
  end

  # double log(double)
  def log jclass,arg,method,thread

    raise 'unimplemented native method : log @ java/lang/StrictMath'
  end

  # double atan(double)
  def atan jclass,arg,method,thread

    raise 'unimplemented native method : atan @ java/lang/StrictMath'
  end

  # double asin(double)
  def asin jclass,arg,method,thread

    raise 'unimplemented native method : asin @ java/lang/StrictMath'
  end

  # double ceil(double)
  def ceil jclass,arg,method,thread

    raise 'unimplemented native method : ceil @ java/lang/StrictMath'
  end

  # double floor(double)
  def floor jclass,arg,method,thread
    arg[0].truncate
    # raise 'unimplemented native method : floor @ java/lang/StrictMath'
  end

  # double atan2(double,double)
  def atan2 jclass,arg,method,thread

    raise 'unimplemented native method : atan2 @ java/lang/StrictMath'
  end

  # double exp(double)
  def exp jclass,arg,method,thread

    raise 'unimplemented native method : exp @ java/lang/StrictMath'
  end

  # double cos(double)
  def cos jclass,arg,method,thread
    Math.cos arg[0]
    # raise 'unimplemented native method : cos @ java/lang/StrictMath'
  end

  # double IEEEremainder(double,double)
  def IEEEremainder jclass,arg,method,thread

    raise 'unimplemented native method : IEEEremainder @ java/lang/StrictMath'
  end

  # double acos(double)
  def acos jclass,arg,method,thread

    raise 'unimplemented native method : acos @ java/lang/StrictMath'
  end

end
