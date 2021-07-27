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

  def my_each_with_index
    return Enumerator.new(self) unless block_given?
    enum_type = self.class

    i = 0 
    loop do 
      yield(self[i], i) if enum_type == Array
      yield([self.keys[i], self.values[i]], i) if enum_type == Hash
      i+=1
      break if i > self.length - 1
    end
    return self
  end

end

module Testable
  def test_my_each(array, hash)
    puts 'each'
    array.each { |item| puts item }
    hash.each { |key, value| puts "#{key}: #{value}"}

    puts 'my_each'
    array.my_each { |item| puts item }
    hash.my_each { |key, value| puts "#{key}: #{value}"}

    #no block 
    array.my_each
    hash.my_each
  end

  def test_my_each_with_index(array, hash)
    puts 'each_with_index'
    array.each_with_index { |item, index| p "#{index}. #{item}"}
    hash.each_with_index { |item, index| p "#{index}. #{item}"}

    puts 'my_each_with_index'
    array.my_each_with_index { |item, index| p "#{index}. #{item}"}
    hash.my_each_with_index { |item, index| p "#{index}. #{item}"}

    #no block
    array.my_each_with_index
    hash.my_each_with_index
  end
end

include Testable

numbers = [1,2,3,4,5]
hash = { a: 'a value', b: 'b value', c: 'c value' }


# puts "each vs. my_each"
# test_my_each(numbers, hash)

puts "each_with_index vs. my_each_with_index"
test_my_each_with_index(numbers, hash)
#binding.pry
puts 'end'