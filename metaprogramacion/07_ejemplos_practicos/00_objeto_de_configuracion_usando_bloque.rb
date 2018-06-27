module Configuracion
  class Internal
    attr_accessor :hostname, :puerto, :usar_ssl

    private def initialize
    end
  end

  def self.configurar
    internal = Internal.new

    yield(internal)

    return internal
  end
end

config = Configuracion.configurar do |configuracion|
  configuracion.hostname = 'www.example.com'
  configuracion.puerto = 80
  configuracion.usar_ssl = false
end

puts "Objeto de configuracion construido: #{config.inspect}"
