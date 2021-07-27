require 'pry'

module Enumerable
  def my_each
    return Enumerator.new(self) unless block_given?
    
    enum_type = self.class
    
    i = 0
    loop do 
      yield(self[i]) if enum_type == Array
      yield(self.keys[i], self.values[i]) if enum_type == Hash
      i+=1
      break if i > self.length - 1
    end
  end
end

module Testable

end

puts "my_each vs. each"
numbers = [1,2,3,4,5]
hash = { a: 'a value', b: 'b value', c: 'c value' }

#numbers.each { |number| puts number }
hash.each { |key, value| puts "#{key}: #{value}"}

#
hash.my_each { |key, value| puts "#{key}: #{value}"}

#numbers.my_each { |number| puts number }

#numbers.my_each