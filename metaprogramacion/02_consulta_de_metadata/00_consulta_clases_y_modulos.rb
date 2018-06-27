module Mod
end

class Super
end

class Foo < Super
  include Mod
end

puts "Clase de la instancia de Foo: #{Foo.new.class.inspect}" # => Foo
puts "Clase de la clase Foo: #{Foo.class.inspect}" # => Class
puts "Super clase de la clase Foo: #{Foo.superclass.inspect}" # => Super
puts "Ancestros de la clase Foo: #{Foo.ancestors.inspect}" # => [Foo, Mod, Super, Object, Kernel, BasicObject]

puts "Modulos incluidos por la clase Foo: #{Foo.included_modules.inspect}" # => [Mod, Kernel]
