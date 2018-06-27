class Foo
  def decir_hola
    puts "Hola mundo"
  end
end

class Foo
  def decir_hola
    puts "De ninguna manera"
  end
end

foo = Foo.new
puts foo.decir_hola # => "De ninguna manera"
