require 'sinatra'

get '/alumno/new' do
  'Formulario de creacion de alumno'
end

post '/alumno/create' do
  'Alumno creado'
end

get '/alumno/edit' do
  'Formulario de edicion del alumno'
end

put '/alumno/update' do
  'Alumno actualizado'
end

delete '/alumno/destroy' do
  'Alumno eliminado'
end
