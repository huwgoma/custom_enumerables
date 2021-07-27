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
  def test_my_each(array, hash)
    puts "each"
    array.each { |item| puts item }
    hash.each { |key, value| puts "#{key}: #{value}"}

    puts "my_each"
    array.my_each { |item| puts item }
    hash.my_each { |key, value| puts "#{key}: #{value}"}

    #no block 
    array.my_each
    hash.my_each
  end
end

include Testable

numbers = [1,2,3,4,5]
hash = { a: 'a value', b: 'b value', c: 'c value' }


puts "my_each vs. each"
test_my_each(numbers, hash)
