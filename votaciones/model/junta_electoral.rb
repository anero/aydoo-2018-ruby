require_relative './provincia'
require_relative './voto'

class JuntaElectoral
  class CandidatoNoReconocido < StandardError
  end

  class ProvinciaNoReconocida < StandardError
  end

  def initialize
    @candidatos = []
    @votos = []
    @provincias = inicializar_provincias
  end

  def agregar_candidato(candidato)
    if candidato.nil?
      raise ArgumentError.new('candidato no puede ser nil')
    end

    unless @candidatos.include?(candidato)
      @candidatos << candidato
    end
  end

  def candidatos
    @candidatos.dup
  end

  def emitir_voto(candidato, provincia)
    unless @candidatos.include?(candidato)
      raise CandidatoNoReconocido
    end
    unless @provincias.include?(provincia)
      raise ProvinciaNoReconocida
    end

    voto_emitido = Voto.new(candidato, provincia)

    @votos << voto_emitido

    voto_emitido
  end

  def resultado_provincial(provincia)
    unless @provincias.include?(provincia)
      raise ProvinciaNoReconocida
    end

    resultados = {}

    @votos
      .select { |voto| voto.provincia == provincia }
      .each do |voto|
        if resultados.has_key?(voto.candidato.nombre)
          resultados[voto.candidato.nombre] += 1
        else
          resultados[voto.candidato.nombre] = 1
        end
      end

    resultados
  end

  def resultado_nacional
    resultado_nacional = {}
    resultados_provinciales = @provincias.map { |provincia| resultado_provincial(provincia) }
    resultados_provinciales.each do |resultado_provincial|
      resultado_nacional.merge!(resultado_provincial) do |nombre_candidato, cant_votos_nacionales, cant_votos_provinciales|
        cant_votos_nacionales + cant_votos_provinciales
      end
    end

    resultado_nacional
  end

  private

  def inicializar_provincias
    provincias = []

    ['Salta', 'Jujuy', 'Formosa', 'Chaco', 'Misiones', 'Corrientes',
      'Chaco', 'Tucumán', 'Salta', 'Catamarca', 'Santiado del Estero',
      'Santa Fé', 'Entre Ríos', 'Córdoba', 'La Rioja', 'San Juan',
      'Mendoza', 'Neuquén', 'La Pampa', 'Buenos Aires', 'Río Negro',
      'Chubut', 'Santa Cruz', 'Tierra del Fuego'
    ].each do |nombre_de_provincia|
      provincias << Provincia.new(nombre_de_provincia)
    end

    provincias
  end
end
