
require "tracer"
$Tracer_depth = 1
$Tracer_output = open("trace-sample/e-log","w")
Tracer.add_filter{|event,file,line,id, binding, klass|
  case event
  when "line"
    break unless file =~ /^\.\/(.+)$/
    id = "top" if id == nil
    $Tracer_output.puts "e ../#{$1} #{$Tracer_depth} #{line} #{id}"
  when "call"
    $Tracer_depth += 1
  when "return"
    $Tracer_depth -= 1
  end
  nil
}

Tracer.on

