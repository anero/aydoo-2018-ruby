require 'rspec'
require_relative '../model/junta_electoral'

describe JuntaElectoral do
  describe 'agregar_candidato' do
    it 'deberia lanzar excepcion si parametro es nil' do
      expect { subject.agregar_candidato(nil) }.to raise_error ArgumentError, 'candidato no puede ser nil'
    end

    it 'deberia agregar el candidato a la lista' do
      candidato = double

      expect(subject.agregar_candidato(candidato)).to be_truthy

      expect(subject.candidatos).to match_array([ candidato ])
    end

    it 'no deberia agregar el mismo candidato multiples veces' do
      candidato = double

      expect(subject.agregar_candidato(candidato)).to be_truthy
      expect(subject.agregar_candidato(candidato)).to be_falsey

      expect(subject.candidatos).to match_array([ candidato ])
    end
  end

  describe 'emitir_voto' do
    it 'deberia lanzar excepcion si el candidato no fue agregado' do
      expect { subject.emitir_voto(double, Provincia.new('Mendoza')) }.to raise_error JuntaElectoral::CandidatoNoReconocido
    end

    it 'deberia lanzar excepcion si la provincia no es valida' do
      candidato = double
      subject.agregar_candidato(candidato)

      expect { subject.emitir_voto(candidato, Provincia.new('Sarasa')) }.to raise_error JuntaElectoral::ProvinciaNoReconocida
    end

    it 'deberia emitir voto para candidato y provincia validos' do
      candidato = double
      subject.agregar_candidato(candidato)
      provincia = Provincia.new('Chubut')

      voto_emitido = subject.emitir_voto(candidato, provincia)

      expect(voto_emitido).not_to be_nil
      expect(voto_emitido.candidato).to eq candidato
      expect(voto_emitido.provincia).to eq provincia
    end
  end

  describe 'resultado_provincial' do
    it 'deberia lanzar excepcion si la provincia no es valida' do
      expect { subject.resultado_provincial(Provincia.new('Sarasa')) }.to raise_error JuntaElectoral::ProvinciaNoReconocida
    end

    it 'deberia devolver coleccion vacia si no hubo votos' do
      resultado = subject.resultado_provincial(Provincia.new('Chubut'))

      expect(resultado).to be_empty
    end

    it 'deberia contar voto para un candidato en la provincia' do
      candidato = double(nombre: 'Juan Perez')
      subject.agregar_candidato(candidato)
      provincia = Provincia.new('Chubut')
      subject.emitir_voto(candidato, provincia)

      resultado = subject.resultado_provincial(provincia)

      expect(resultado).not_to be_empty
      expect(resultado['Juan Perez']).to eq 1
    end

    it 'deberia contar votos para un candidato en la provincia' do
      candidato = double(nombre: 'Juan Perez')
      subject.agregar_candidato(candidato)
      provincia = Provincia.new('Chubut')
      subject.emitir_voto(candidato, provincia)
      subject.emitir_voto(candidato, provincia)

      resultado = subject.resultado_provincial(provincia)

      expect(resultado).not_to be_empty
      expect(resultado['Juan Perez']).to eq 2
    end

    it 'no deberia contar votos para un candidato en otras provincias' do
      candidato = double(nombre: 'Juan Perez')
      subject.agregar_candidato(candidato)
      chubut = Provincia.new('Chubut')
      subject.emitir_voto(candidato, chubut)
      san_juan = Provincia.new('San Juan')
      subject.emitir_voto(candidato, san_juan)

      resultado = subject.resultado_provincial(chubut)

      expect(resultado).not_to be_empty
      expect(resultado['Juan Perez']).to eq 1
    end

    it 'deberia contar votos para multiples candidatos en la provincia' do
      provincia = Provincia.new('Chubut')
      juan_perez = double(nombre: 'Juan Perez')
      subject.agregar_candidato(juan_perez)
      subject.emitir_voto(juan_perez, provincia)
      ana_rodriguez = double(nombre: 'Ana Rodriguez')
      subject.agregar_candidato(ana_rodriguez)
      subject.emitir_voto(ana_rodriguez, provincia)

      resultado = subject.resultado_provincial(provincia)

      expect(resultado).not_to be_empty
      expect(resultado['Juan Perez']).to eq 1
      expect(resultado['Ana Rodriguez']).to eq 1
    end

    describe 'resultado_nacional' do
      it 'deberia devolver coleccion vacia si no hubo votos' do
        expect(subject.resultado_nacional).to be_empty
      end

      it 'deberia contar voto para un candidato en una provincia' do
        candidato = double(nombre: 'Juan Perez')
        subject.agregar_candidato(candidato)
        provincia = Provincia.new('Chubut')
        subject.emitir_voto(candidato, provincia)

        resultado = subject.resultado_nacional

        expect(resultado).not_to be_empty
        expect(resultado['Juan Perez']).to eq 1
      end

      it 'deberia contar votos para un candidato en multiples provincias' do
        candidato = double(nombre: 'Juan Perez')
        subject.agregar_candidato(candidato)
        chubut = Provincia.new('Chubut')
        subject.emitir_voto(candidato, chubut)
        san_juan = Provincia.new('San Juan')
        subject.emitir_voto(candidato, san_juan)

        resultado = subject.resultado_nacional

        expect(resultado).not_to be_empty
        expect(resultado['Juan Perez']).to eq 2
      end

      it 'deberia contar votos para varios candidatos en multiples provincias' do
        candidato = double(nombre: 'Juan Perez')
        subject.agregar_candidato(candidato)
        chubut = Provincia.new('Chubut')
        subject.emitir_voto(candidato, chubut)
        san_juan = Provincia.new('San Juan')
        subject.emitir_voto(candidato, san_juan)
        ana_rodriguez = double(nombre: 'Ana Rodriguez')
        subject.agregar_candidato(ana_rodriguez)
        subject.emitir_voto(ana_rodriguez, san_juan)

        resultado = subject.resultado_nacional

        expect(resultado).not_to be_empty
        expect(resultado['Juan Perez']).to eq 2
        expect(resultado['Ana Rodriguez']).to eq 1
      end
    end
  end
end
