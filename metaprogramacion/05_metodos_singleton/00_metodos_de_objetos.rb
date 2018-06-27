class Perro
end

perro_1 = Perro.new

def perro_1.saludar
  puts "guau (desde la instancia perro_1 de Perro)"
end

perro_2 = Perro.new

perro_1.saludar
perro_2.saludar # => lanza NoMethodError
