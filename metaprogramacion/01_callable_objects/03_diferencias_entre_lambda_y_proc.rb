def llamar_al_callable(c)
  c.call(2)
  puts "ese fue el resultado del call"
end

lambda_1 = ->(x) { return x * 10 }
llamar_al_callable(lambda_1) # => 20 + string "ese fue el resultado del call"

proc_1 = Proc.new {|x| return x * 10 }
llamar_al_callable(proc_1) # => arroja excepción "LocalJumpError: unexpected return"
