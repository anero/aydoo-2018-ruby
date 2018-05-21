require 'rspec'
require_relative '../model/voto'

describe Voto do
  describe 'constructor' do
    it 'debe lanzar excepcion si el candidato es nil' do
      expect { Voto.new(nil, double) }.to raise_error ArgumentError, 'El candidato no puede ser nil'
    end

    it 'debe lanzar excepcion si la provincia es nil' do
      expect { Voto.new(double, nil) }.to raise_error ArgumentError, 'La provincia no puede ser nil'
    end

    it 'debe asignar parametros del constructor a atributos' do
      candidato = double
      provincia = double

      subject = Voto.new(candidato, provincia)

      expect(subject.candidato).to be candidato
      expect(subject.provincia).to be provincia
    end
  end
end
