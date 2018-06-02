require 'rspec'
require 'rack/test'
require 'byebug'
require_relative ENV['SINATRA_APP_PATH']

describe 'Fibo5' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'deberia devolver sucesion para limite 1' do
    get '/fibonacci/1/lista'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 1
    expect(respuesta_parseada['fibonacci']['lista']).to eq [0, 1]
  end

  it 'deberia devolver lista' do
    get '/fibonacci/8/lista'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 8
    expect(respuesta_parseada['fibonacci']['lista']).to eq [0, 1, 1, 2, 3, 5, 8, 13]
  end

  it 'deberia devolver sumatoria' do
    get '/fibonacci/8/sumatoria'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 8
    expect(respuesta_parseada['fibonacci']['sumatoria']).to eq 33
  end

  it 'deberia devolver lista en sentido inverso' do
    get '/fibonacci/7/lista?sentido=inverso'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 7
    expect(respuesta_parseada['fibonacci']['lista']).to eq [8, 5, 3, 2, 1, 1, 0]
  end

  it 'deberia devolver lista en sentido directo' do
    get '/fibonacci/7/lista?sentido=directo'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 7
    expect(respuesta_parseada['fibonacci']['lista']).to eq [0, 1, 1, 2, 3, 5, 8]
  end

  it 'deberia devolver lista de solo pares' do
    get '/fibonacci/10/lista?solo=pares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['lista']).to eq [2, 8, 34]
  end

  it 'deberia devolver lista de solo impares' do
    get '/fibonacci/10/lista?solo=impares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['lista']).to eq [1, 1, 3, 5, 13, 21]
  end

  it 'deberia devolver lista en sentido inverso de solo pares' do
    get '/fibonacci/10/lista?sentido=inverso&solo=pares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['lista']).to eq [34, 8, 2]
  end

  it 'deberia devolver lista en sentido inverso de solo impares' do
    get '/fibonacci/10/lista?sentido=inverso&solo=impares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['lista']).to eq [21, 13, 5, 3, 1, 1]
  end

  it 'orden de parametros no deberian importar' do
    get '/fibonacci/10/lista?solo=pares&sentido=inverso'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['lista']).to eq [34, 8, 2]
  end

  it 'deberia sumar solo pares' do
    get '/fibonacci/10/sumatoria?solo=pares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['sumatoria']).to eq 44
  end

  it 'deberia sumar solo impares' do
    get '/fibonacci/10/sumatoria?solo=impares'

    expect(last_response).to be_ok
    respuesta_parseada = JSON.parse(last_response.body)
    expect(respuesta_parseada['fibonacci']).not_to be_nil
    expect(respuesta_parseada['fibonacci']['limite']).to eq 10
    expect(respuesta_parseada['fibonacci']['sumatoria']).to eq 44
  end

  context 'deberia devolver 400 - Bad Request si' do
    it 'limite es 0' do
      get '/fibonacci/0/lista'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'limite es menor a 0' do
      get '/fibonacci/-10/lista'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'modo no es valido' do
      get '/fibonacci/10/foo'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'orden de parametros incorrecto' do
      get '/fibonacci/lista/10'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'limite no es un numero' do
      get '/fibonacci/a/lista'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'valor invalido para parametro sentido' do
      get '/fibonacci/10/lista?sentido=foo'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'valor invalido para parametro solo' do
      get '/fibonacci/10/lista?solo=foo'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'valor valido para parametro sentido e invalido para solo' do
      get '/fibonacci/10/lista?sentido=directo&solo=foo'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end

    it 'valor valido para parametro solo e invalido para sentido' do
      get '/fibonacci/10/lista?sentido=foo&solo=pares'

      expect(last_response).to be_bad_request
      respuesta_parseada = JSON.parse(last_response.body)
      expect(respuesta_parseada['error']).to eq 'Opción no válida'
    end
  end
end
