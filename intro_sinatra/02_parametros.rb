require 'sinatra'

get '/alumno/new' do
  'Formulario de creacion de alumno'
end

post '/alumno/create' do
  "Alumno creado con nombre: #{params[:nombre]}"
end

get '/alumno/edit' do
  "Formulario de edicion del alumno con ID: #{params[:id]}"
end

put '/alumno/update' do
  "Alumno con ID #{params[:id]} actualizado con nombre: #{params[:nombre]}"
end

delete '/alumno/destroy/:id' do
  "Alumno con ID #{params[:id]} eliminado"
end
