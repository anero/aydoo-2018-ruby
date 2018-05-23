require_relative '../04_testing'
require 'rspec'
require 'rack/test'

describe 'Aplicacion Sinatra' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/hola_mundo' do
    it 'deberia devolver saludo' do
      get '/hola_mundo'

      expect(last_response).to be_ok
      expect(last_response.body).to eq 'Hola Mundo!'
    end
  end

  describe '/crear_superheroe' do
    it 'deberia devolver codigo de estado 400 si parametro nombre no provisto' do
      post '/crear_superheroe'

      expect(last_response).to be_bad_request
    end

    it 'deberia devolver superheroe en formato JSON si nombre provisto' do
      post '/crear_superheroe?nombre=wolverine'

      expect(last_response).to be_ok
      cuerpo_parseado = JSON.parse(last_response.body)
      expect(cuerpo_parseado['nombre']).to eq 'wolverine'
      expect(cuerpo_parseado['super_poder']).to eq 'regeneracion'
    end
  end
end
