module Mod
  def self.included(mod)
    attr_accessor(:atributo_de_instancia_3)
  end
end

class Super
  @atributo_de_clase_2 = 'Atributo de la clase Super'

  def initialize
    @atributo_de_instancia_2 = 'Atributo de instancia de Super'
  end
end

class Foo < Super
  include Mod

  @atributo_de_clase_1 = 'Atributo de la clase Foo'

  def initialize
    @atributo_de_instancia_1 = 'Atributo de instancia de Foo'
  end
end

foo = Foo.new

puts "Variables de instancia de instancia de Foo: #{foo.instance_variables}"
puts "Variables de instancia de Foo: #{Foo.instance_variables}"
