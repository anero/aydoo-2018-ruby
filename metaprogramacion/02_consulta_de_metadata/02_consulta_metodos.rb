module Mod
  def metodo_desde_mod
  end

  def self.metodo_de_clase_desde_mod
  end

  protected def metodo_protected_desde_mod
  end

  private def metodo_private_desde_mod
  end
end

class Super
  def metodo_public_desde_super
  end

  def self.metodo_de_clase_desde_super
  end

  protected def metodo_protected_desde_super
  end

  private def metodo_privado_desde_super
  end
end

class Foo < Super
  include Mod

  def metodo_desde_foo
  end

  def self.metodo_de_clase_desde_foo
  end

  protected def metodo_protected_desde_foo
  end

  private def metodo_private_desde_foo
  end
end

foo = Foo.new

def foo.metodo_singleton_desde_foo
end

puts "Metodos publicos y protegidos de instancia de Foo: #{foo.methods.inspect}\n\n" # => [:metodo_singleton_desde_foo, :metodo_desde_foo, :metodo_protected_desde_foo, :metodo_desde_mod, :metodo_protected_desde_mod, :metodo_public_desde_super, :metodo_protected_desde_super, ...]
puts "Metodos singleton de foo: #{foo.methods(false).inspect}\n\n" # => [:metodo_singleton_desde_foo]

puts "Metodos de clase de Foo: #{Foo.methods.inspect}" # => [:metodo_de_clase_desde_foo, :metodo_de_clase_desde_super, ...]
