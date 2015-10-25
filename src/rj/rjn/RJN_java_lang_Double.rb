class RJN_java_lang_Double < RJNative

  # long doubleToRawLongBits(double)
  def doubleToRawLongBits jclass,arg,method,thread
    #raise 'unimplemented native method : doubleToRawLongBits @ java/lang/Double'
    s = ([arg[0]].pack 'G')
    a = s.unpack 'iI'
    (a[0] << 32) | (a[1])
  end

  # long doubleToLongBits(double)
  def doubleToLongBits jclass,arg,method,thread
    s = ([arg[0]].pack 'G')
    a = s.unpack 'iI'
    (a[0] << 32) | (a[1])
    #raise 'unimplemented native method : doubleToLongBits @ java/lang/Double'
  end

  # double longBitsToDouble(long)
  def longBitsToDouble jclass,arg,method,thread
    l = arg[0]
    s = [l >> 32 , l & 0xffffffff].pack 'iI'
    (s.unpack 'G')[0]
    # raise 'unimplemented native method : longBitsToDouble @ java/lang/Double'
  end

end
