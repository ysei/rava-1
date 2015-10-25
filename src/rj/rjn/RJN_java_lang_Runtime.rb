class RJN_java_lang_Runtime < RJNative

  # void runFinalization0()
  def runFinalization0 jclass,arg,method,thread

    raise 'unimplemented native method : runFinalization0 @ java/lang/Runtime'
  end

  # void traceInstructions(boolean)
  def traceInstructions this,arg,method,thread

    raise 'unimplemented native method : traceInstructions @ java/lang/Runtime'
  end

  # java.lang.Process execInternal(java.lang.String[],java.lang.String[],java.lang.String)
  def execInternal this,arg,method,thread

    raise 'unimplemented native method : execInternal @ java/lang/Runtime'
  end

  # long freeMemory()
  def freeMemory this,arg,method,thread
    1024 * 1024 * 128
    # raise 'unimplemented native method : freeMemory @ java/lang/Runtime'
  end

  # void gc()
  def gc this,arg,method,thread

    raise 'unimplemented native method : gc @ java/lang/Runtime'
  end

  # void traceMethodCalls(boolean)
  def traceMethodCalls this,arg,method,thread

    raise 'unimplemented native method : traceMethodCalls @ java/lang/Runtime'
  end

  # long totalMemory()
  def totalMemory this,arg,method,thread

    raise 'unimplemented native method : totalMemory @ java/lang/Runtime'
  end

end
