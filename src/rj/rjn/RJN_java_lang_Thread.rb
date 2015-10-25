
class RJThreadInstance < RJInstance
  JThreadClass = RJClassManager.instance.get('java.lang.Thread')

  def initialize th
    super JThreadClass
    @thread = th
    self['group'] = RJClassManager.instance.get('java.lang.ThreadGroup').create_instance
    self['priority'] = 5
    self['inheritableThreadLocals'] =
      RJClassManager.instance.get('java.util.HashMap').create_instance
  end
  
  def to_s
    "Java Thread Instance"
  end
end


class RJN_java_lang_Thread < RJNative

  # void sleep(long)
  def sleep jclass,arg,method,thread

    raise 'unimplemented native method : sleep @ java/lang/Thread'
  end

  # void yield()
  def yield jclass,arg,method,thread

    raise 'unimplemented native method : yield @ java/lang/Thread'
  end

  # boolean isInterrupted(boolean)
  def isInterrupted this,arg,method,thread

    raise 'unimplemented native method : isInterrupted @ java/lang/Thread'
  end

  # void interrupt0()
  def interrupt0 this,arg,method,thread

    raise 'unimplemented native method : interrupt0 @ java/lang/Thread'
  end

  # void resume0()
  def resume0 this,arg,method,thread

    raise 'unimplemented native method : resume0 @ java/lang/Thread'
  end

  # void start()
  def start this,arg,method,thread
    t = RJThreadManager.instance.create
    t.set_run this
    t.kick
    # raise 'unimplemented native method : start @ java/lang/Thread'
  end

  # java.lang.Thread currentThread()
  def currentThread jclass,arg,method,thread
    RJThreadInstance.new thread
    # raise 'unimplemented native method : currentThread @ java/lang/Thread'
  end

  # void stop0(java.lang.Object)
  def stop0 this,arg,method,thread

    raise 'unimplemented native method : stop0 @ java/lang/Thread'
  end

  # boolean isAlive()
  def isAlive this,arg,method,thread

    raise 'unimplemented native method : isAlive @ java/lang/Thread'
  end

  # void registerNatives()
  def registerNatives jclass,arg,method,thread

    # raise 'unimplemented native method : registerNatives @ java/lang/Thread'
  end

  # int countStackFrames()
  def countStackFrames this,arg,method,thread

    raise 'unimplemented native method : countStackFrames @ java/lang/Thread'
  end

  # void suspend0()
  def suspend0 this,arg,method,thread

    raise 'unimplemented native method : suspend0 @ java/lang/Thread'
  end

  # void setPriority0(int)
  def setPriority0 this,arg,method,thread
    # “Á‚Éi‚±‚±‚Å‚Íj‰½‚à‚µ‚È‚¢
    
    # raise 'unimplemented native method : setPriority0 @ java/lang/Thread'
  end

end
