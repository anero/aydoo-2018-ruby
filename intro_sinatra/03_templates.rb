require 'sinatra'
require 'byebug'

@@alumnos = {}
@@ultimo_id_asignado = 0

get '/alumno/new' do
  @hora = Time.now
  erb :new
end

post '/alumno/create' do
  @@ultimo_id_asignado += 1
  @@alumnos[@@ultimo_id_asignado] = params[:nombre]

  redirect to('/alumnos')
end

get '/alumno/show/:id' do
  unless @@alumnos.has_key?(params[:id].to_i)
    halt(404)
    return
  end

  @alumno = @@alumnos[params[:id].to_i]
  erb :show
end

get '/alumno/edit/:id' do
  unless @@alumnos.has_key?(params[:id].to_i)
    halt(404)
    return
  end

  @alumno = @@alumnos[params[:id].to_i]

  erb :edit
end

put '/alumno/update/:id' do
  unless @@alumnos.has_key?(params[:id].to_i)
    halt(404)
    return
  end

  @@alumnos[params[:id].to_i] = params[:nombre]

  redirect to('/alumnos')
end

delete '/alumno/destroy/:id' do
  unless @@alumnos.has_key?(params[:id].to_i)
    halt(404)
    return
  end

  @@alumnos.delete(params[:id].to_i)

  redirect to('/alumnos')
end

get '/alumnos' do
  @alumnos = @@alumnos.map {|id, nombre| { id: id, nombre: nombre } }
  erb :index
end