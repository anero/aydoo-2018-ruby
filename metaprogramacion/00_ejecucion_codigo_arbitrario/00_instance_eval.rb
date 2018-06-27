class Persona
  attr_reader :nombre
end

una_persona = Persona.new
una_persona.instance_eval('@nombre = "Jose"')
puts una_persona.nombre
