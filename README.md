Chopper, proyecto base ruby
===========================


## Preparación del ambiente

````
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install -y git
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2.0
cd chopper
gem install bundler
````

## Uso del proyecto

Una vez realizada la instalación:

1. Instalar las dependencias del proyecto ejecutando _bundle install_
2. Ejecutar las pruebas ejecutando _bundle exec rake_


## Para crear nuevos proyectos

Para resolver los ejercicios deben:

1. Crear un nuevo branch de master con el nombre del ejercicio
1. Crear un nuevo subdirectorio con el nombre del ejercicio en el directorio raíz
1. Copiar el contenido del proyecto de ejemplo (/chopper)
1. Borrar los archivos de ejemplo (`/model/chopper.rb` y `/spec/chopper_spec.rb`) del proyecto del ejercicio nuevo
