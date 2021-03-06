require 'byebug'

class Object
  def eigenclass
    class << self
      self
    end
  end
end

class C
  def un_metodo
    puts 'C#un_metodo'
  end

  def self.un_metodo_de_clase
    puts '#C.un_metodo_de_clase'
  end
end

class D < C
end

obj = D.new
def obj.un_metodo_singleton
  puts '#obj.un_metodo_singleton'
end

puts obj.eigenclass
puts obj.eigenclass.superclass
puts D.eigenclass.superclass

byebug
puts ''
