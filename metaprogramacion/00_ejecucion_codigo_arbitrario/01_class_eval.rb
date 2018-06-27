class Persona
end

Persona.class_eval('def saludar; puts "hola"; end')

Persona.new.saludar
