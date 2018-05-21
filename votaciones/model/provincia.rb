class Provincia
  attr_reader :nombre

  def initialize(nombre)
    if nombre.nil? || nombre == ''
      raise ArgumentError.new('nombre invalido')
    end

    @nombre = nombre
  end

  def ==(otro_objeto)
    unless otro_objeto.is_a?(Provincia)
      return false
    end

    self.nombre == otro_objeto.nombre
  end
end
