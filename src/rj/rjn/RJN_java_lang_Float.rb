class RJN_java_lang_Float < RJNative

  # float intBitsToFloat(int)
  def intBitsToFloat jclass,arg,method,thread
    (([arg[0]].pack 'i').unpack 'g')[0]
    
    # raise 'unimplemented native method : intBitsToFloat @ java/lang/Float'
  end

  # int floatToRawIntBits(float)
  def floatToRawIntBits jclass,arg,method,thread
    (([arg[0]].pack 'g').unpack 'i')[0]
    # raise 'unimplemented native method : floatToRawIntBits @ java/lang/Float'
  end

  # int floatToIntBits(float)
  def floatToIntBits jclass,arg,method,thread
    (([arg[0]].pack 'g').unpack 'i')[0]
    # raise 'unimplemented native method : floatToIntBits @ java/lang/Float'
  end

end
