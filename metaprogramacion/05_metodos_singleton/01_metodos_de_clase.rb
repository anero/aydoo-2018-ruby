class Perro
  def self.saludar
    puts "guau (desde el objeto Perro)"
  end
end

Perro.saludar

perro = Perro.new
perro.saludar # => lanza NoMethodError
