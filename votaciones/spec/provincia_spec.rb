require 'rspec'
require_relative '../model/provincia'

describe Provincia do
  describe 'constructor' do
    it 'debe lanzar excepcion si el nombre es nil' do
      expect { Provincia.new(nil) }.to raise_error ArgumentError, 'nombre invalido'
    end

    it 'debe lanzar excepcion si el nombre es un string vacio' do
      expect { Provincia.new('') }.to raise_error ArgumentError, 'nombre invalido'
    end

    it 'debe asignar parametro al atributo' do
      subject = Provincia.new('Mendoza')

      expect(subject.nombre).to eq 'Mendoza'
    end
  end

  describe '==' do
    subject { Provincia.new('La Pampa') }

    it 'debe ser distinto si objeto comparado no es de clase Provincia' do
      expect(subject).not_to eq(Object.new)
    end

    it 'debe ser distinto si objeto comparado es nil' do
      expect(subject).not_to eq(nil)
    end

    it 'debe ser distinto si objeto comparado tiene otro nombre' do
      otro_objeto = Provincia.new('Buenos Aires')

      expect(subject).not_to eq(otro_objeto)
    end

    it 'debe ser igual si otro objeto tiene el mismo nombre' do
      otro_objeto = Provincia.new('La Pampa')

      expect(subject).to eq(otro_objeto)
    end
  end
end
