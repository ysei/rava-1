class RJN_test < RJNative

  # void out(long)
  # void out(java.lang.String)
  # void out(int)
  def out jclass,arg,method,thread
    case method.mdesc
    # void out(long)
    when '(J)V'
      puts '== long output =='
      puts arg[0].to_s
    # void out(java.lang.String)
    when '(Ljava/lang/String;)V'
      puts '== string output =='
      puts arg[0].to_s
      
    # void out(int)
    when '(I)V'
      puts '== integer output =='
      puts arg[0].to_s

    # void out(double)
    when '(D)V'
      puts '== double output =='
      puts arg[0].to_s

    end
    # raise 'unimplemented native method : out @ test'
  end

  # void iout(java.lang.String)
  def iout this,arg,method,thread

    raise 'unimplemented native method : iout @ test'
  end

end
