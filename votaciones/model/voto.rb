class Voto
  attr_reader :candidato, :provincia

  def initialize(candidato, provincia)
    if candidato.nil?
      raise ArgumentError.new('El candidato no puede ser nil')
    end
    if provincia.nil?
      raise ArgumentError.new('La provincia no puede ser nil')
    end

    @candidato = candidato
    @provincia = provincia
  end
end
