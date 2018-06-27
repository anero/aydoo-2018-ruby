def un_metodo
  a = 1
  b = 10

  binding
end

eval 'puts a + b', un_metodo

puts a + b # => undefined local variable or method `a'
