class Foo
end

puts Foo.new.methods.inspect # => [:nil?, :===, ...]

foo = Foo.new

class Foo
  def un_metodo_agregado
  end
end

puts Foo.new.methods.inspect # => [:un_metodo_agregado, :nil?, :===, ...]
puts foo.methods.inspect # => [:un_metodo_agregado, :nil?, :===, ...]
