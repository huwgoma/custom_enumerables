module Testable
  def test_my_each(array, hash)
    puts 'each'.bold
    array.each { |item| puts item }
    hash.each { |key, value| puts "#{key}: #{value}"}

    puts 'my_each'.bold
    array.my_each { |item| puts item }
    hash.my_each { |key, value| puts "#{key}: #{value}"}
  end

  def test_my_each_with_index(array, hash)
    puts 'each_with_index'.bold
    array.each_with_index { |item, index| p "#{index}. #{item}"}
    hash.each_with_index { |item, index| p "#{index}. #{item}"}

    puts 'my_each_with_index'.bold
    array.my_each_with_index { |item, index| p "#{index}. #{item}"}
    hash.my_each_with_index { |item, index| p "#{index}. #{item}"}
  end

  def test_my_select(array, hash)
    puts 'select'.bold
    p array.select { |item| [1, 3].include?(item) }
    p hash.select { |key, value| key == :a || value == 'b value' }
    
    puts 'my_select'.bold
    p array.my_select { |item| [1, 3].include?(item) }
    p hash.my_select { |key,value| key == :a || value == 'b value' }
  end

  def test_my_all?(array, hash)
    puts 'all?'.bold
    p array.all? { |item| Integer === item }
    p array.all? { |item| item < 5 }
    p hash.all? { |key, value| value.class == String }
    p hash.all? { |key, value| key == :a }

    p [1, 2, 3, nil].all?
    p hash.all? 

    p array.all?(Integer)
    p array.all?(Integer) {|item|}


    puts 'my_all?'.bold
    p array.my_all? { |item| Integer === item }
    p array.my_all? { |item| item < 3 }
    p hash.my_all? { |key, value| value.class == String }
    p hash.my_all? { |key, value| key == :a }

    p [1, 2, 3, nil].my_all?
    p hash.my_all?

    p array.my_all?(Integer)
    p array.my_all?(Integer) {|item|}
  end

  def test_my_any?(array, hash)

  end
end