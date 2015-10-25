class RJN_java_security_AccessController < RJNative

  # java.lang.Object doPrivileged(java.security.PrivilegedExceptionAction,java.security.AccessControlContext)
  # java.lang.Object doPrivileged(java.security.PrivilegedAction)
  # java.lang.Object doPrivileged(java.security.PrivilegedExceptionAction)
  # java.lang.Object doPrivileged(java.security.PrivilegedAction,java.security.AccessControlContext)
  def doPrivileged jclass,arg,method,thread
    case method.mdesc
    # java.lang.Object doPrivileged(java.security.PrivilegedExceptionAction,java.security.AccessControlContext)
    when '(Ljava/security/PrivilegedExceptionAction;Ljava/security/AccessControlContext;)Ljava/lang/Object;'

    # java.lang.Object doPrivileged(java.security.PrivilegedAction)
    when '(Ljava/security/PrivilegedAction;)Ljava/lang/Object;'

    # java.lang.Object doPrivileged(java.security.PrivilegedExceptionAction)
    when '(Ljava/security/PrivilegedExceptionAction;)Ljava/lang/Object;'

    # java.lang.Object doPrivileged(java.security.PrivilegedAction,java.security.AccessControlContext)
    when '(Ljava/security/PrivilegedAction;Ljava/security/AccessControlContext;)Ljava/lang/Object;'


    end
    raise 'unimplemented native method : doPrivileged @ java/security/AccessController'
  end

  # java.security.AccessControlContext getInheritedAccessControlContext()
  def getInheritedAccessControlContext jclass,arg,method,thread

    raise 'unimplemented native method : getInheritedAccessControlContext @ java/security/AccessController'
  end

  # java.security.AccessControlContext getStackAccessControlContext()
  def getStackAccessControlContext jclass,arg,method,thread
    nil
    # raise 'unimplemented native method : getStackAccessControlContext @ java/security/AccessController'
  end

end
