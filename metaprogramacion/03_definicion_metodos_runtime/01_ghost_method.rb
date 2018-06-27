class Foo
  def method_missing(symbol, *args)
    puts "Hola desde #{symbol}"
  end
end

foo = Foo.new

foo.sarasa # => "Hola desde sarasa"
foo.lalala # => "Hola desde lalala"
