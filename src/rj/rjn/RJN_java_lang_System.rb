class RJN_java_lang_System < RJNative

  # long currentTimeMillis()
  def currentTimeMillis jclass,arg,method,thread
    Time.now.tv_sec * 1000
    # raise 'unimplemented native method : currentTimeMillis @ java/lang/System'
  end

  # void setIn0(java.io.InputStream)
  def setIn0 jclass,arg,method,thread

    raise 'unimplemented native method : setIn0 @ java/lang/System'
  end

  # void setErr0(java.io.PrintStream)
  def setErr0 jclass,arg,method,thread

    raise 'unimplemented native method : setErr0 @ java/lang/System'
  end

  # void setOut0(java.io.PrintStream)
  def setOut0 jclass,arg,method,thread

    raise 'unimplemented native method : setOut0 @ java/lang/System'
  end

  # java.lang.Class getCallerClass()
  def getCallerClass jclass,arg,method,thread

    raise 'unimplemented native method : getCallerClass @ java/lang/System'
  end

  # void arraycopy(java.lang.Object,int,java.lang.Object,int,int)
  def arraycopy jclass,arg,method,thread
    src = arg[0]
    sp  = arg[1]
    dst = arg[2]
    dp  = arg[3]
    len = arg[4]

    # check
    
    len.times{|i|
      dst[i+dp] = src[i+sp]
    }

    # raise 'unimplemented native method : arraycopy @ java/lang/System'
  end

  # java.util.Properties initProperties(java.util.Properties)
  def initProperties jclass,arg,method,thread

    raise 'unimplemented native method : initProperties @ java/lang/System'
  end

  # void registerNatives()
  def registerNatives jclass,arg,method,thread

    # raise 'unimplemented native method : registerNatives @ java/lang/System'
  end

  # int identityHashCode(java.lang.Object)
  def identityHashCode jclass,arg,method,thread

    raise 'unimplemented native method : identityHashCode @ java/lang/System'
  end

  # java.lang.String mapLibraryName(java.lang.String)
  def mapLibraryName jclass,arg,method,thread

    raise 'unimplemented native method : mapLibraryName @ java/lang/System'
  end

end
