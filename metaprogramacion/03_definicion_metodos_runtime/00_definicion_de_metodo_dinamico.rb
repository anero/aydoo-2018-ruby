class Foo
end

nombre_del_nuevo_metodo = 'nuevo_metodo'
Foo.send(:define_method, nombre_del_nuevo_metodo) do
  puts "Hola desde #{nombre_del_nuevo_metodo}"
end

foo = Foo.new
foo.nuevo_metodo # =>  "Hola desde nuevo_metodo"
