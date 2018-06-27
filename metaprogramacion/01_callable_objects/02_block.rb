def un_metodo_sin_bloque_explicito
  yield('a', 'b')
end

un_metodo_sin_bloque_explicito {|x, y| puts "x = #{x} | y = #{y}" } # => x = a | y = b

def un_metodo_con_bloque_explicito(&bloque)
  bloque.call('v', 'w')
end

un_metodo_con_bloque_explicito {|x, y| puts "x = #{x} | y = #{y}" } # => x = v | y = w


def un_metodo_con_parametros_para_el_bloque(param_1, param_2)
  yield(param_1, param_2)
end

un_metodo_con_parametros_para_el_bloque(1, 5) {|p1, p2| puts "p1 = #{p1} | p2 = #{p2}"  } # => p1 = 1 | p2 = 5
