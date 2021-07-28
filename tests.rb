module Testable
  def test_my_each(array, hash)
    puts 'each'
    array.each { |item| puts item }
    hash.each { |key, value| puts "#{key}: #{value}"}

    puts 'my_each'
    array.my_each { |item| puts item }
    hash.my_each { |key, value| puts "#{key}: #{value}"}
  end

  def test_my_each_with_index(array, hash)
    puts 'each_with_index'
    array.each_with_index { |item, index| p "#{index}. #{item}"}
    hash.each_with_index { |item, index| p "#{index}. #{item}"}

    puts 'my_each_with_index'
    array.my_each_with_index { |item, index| p "#{index}. #{item}"}
    hash.my_each_with_index { |item, index| p "#{index}. #{item}"}
  end

  def test_my_select(array, hash)
    puts 'select'
    p array.select { |item| [1, 3].include?(item) }
    p hash.select { |key, value| key == :a || value == 'b value' }
    
    puts 'my_select'
    p array.my_select { |item| [1, 3].include?(item) }
    p hash.my_select { |key,value| key == :a || value == 'b value' }
  end
end