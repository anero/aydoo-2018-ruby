require 'sinatra'
require 'sinatra/json'

get '/hola_mundo' do
  'Hola Mundo!'
end

post '/crear_superheroe' do
  if params[:nombre].nil?
    halt(400)
    return
  end

  json({ nombre: params[:nombre], super_poder: 'regeneracion' })
end
