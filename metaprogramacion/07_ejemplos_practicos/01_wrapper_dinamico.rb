class Persona
  attr_accessor :nombre, :apellido, :telefono
end

class WrapperPersona
  def initialize
    @persona = Persona.new
  end

  def method_missing(nombre_metodo, *args)
    if (@persona.respond_to?(nombre_metodo))
      return @persona.send(nombre_metodo, *args)
    end
  end
end

wrapper_persona = WrapperPersona.new

wrapper_persona.nombre = 'Lola'
wrapper_persona.apellido = 'Rodriguez'

puts wrapper_persona.nombre
puts wrapper_persona.apellido
