class Perro
  class << self
    def otro_saludar
      puts "guau (desde el objeto Perro también)"
    end
  end
end

Perro.otro_saludar
