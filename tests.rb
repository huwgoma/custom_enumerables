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
    puts 'any?'.bold
    # p array.any? { |item| Integer === item }
    # p array.any? { |item| item > 5 }
    # p hash.any? { |key, value| value == 'String' }
    # p hash.any? { |key, value| key == :a }

    p [1, 2, 3, nil].any?
    p hash.any? 

    p array.any?(String)
    p array.any?(Integer) {|item|}

    puts 'my_any?'.bold
    # p array.my_any? { |item| Integer === item }
    # p array.my_any? { |item| item > 5 }
    # p hash.my_any? { |key, value| value == 'String' }
    # p hash.my_any? { |key, value| key == :a }

    p [1, 2, 3, nil].my_any?
    p hash.my_any?

    p array.my_any?(String)
    p array.my_any?(Integer) {|item|}
  end

  def test_my_none?(array, hash)
    puts 'none?'.bold
    p array.none? { |item| item == 1 }
    p array.none? { |item| item == '1' }
    
    p [1,2,3,nil].none?
    p hash.none?

    p array.none?(String)
    p array.none?(Integer) {|item|}

    puts 'my_none?'.bold
    p array.my_none? { |item| item == 1 }
    p array.my_none? { |item| item == '1' }
    
    p [1,2,3,nil].my_none?
    p hash.my_none?

    p array.my_none?(String)
    p array.my_none?(Integer) {|item|}
  end

  def test_my_count(array, hash)
    puts 'count'.bold
    p array.count
    p hash.count

    p array.count(1)
    p hash.count(0)
    p array.count(1) { |item| }

    p array.count { |item| item > 3 }
    p hash.count { |key, value| key == :a }

    puts 'my_count'.bold
    p array.my_count
    p hash.my_count

    p array.my_count(1)
    p hash.my_count(0)
    p array.my_count(1) { |item| } 
    
    p array.my_count { |item| item > 3 }
    p hash.my_count { |key, value| key == :a }
  end

  def test_my_map(array, hash)
    puts 'map'.bold
    p array.map
    p array.map { |item| item + 1 }
    p hash.map { |key, value| value = 'map' }

    puts 'my_map'.bold
    p array.my_map
    p array.my_map { |item| item + 1 }
    p hash.my_map { |key, value| value = 'map' }
  end

  #Reduce
  def test_my_reduce(array, hash)
    puts 'reduce'.bold
    #array.reduce
    p array.reduce { |sum, item| sum + item }
    p hash.reduce('') { |sum, kv| sum + kv[1] }
    p array.reduce(10) { |sum, item| sum + item }
    
    p array.reduce(:+)
    p array.reduce(10, :+)
    

    puts 'my_reduce'.bold
    #array.my_reduce
    # p array.my_reduce { |sum, item| sum + item }
    # p hash.my_reduce('') { |sum, kv| sum + kv[1] }
    # p array.my_reduce(10) { |sum, item| sum + item }

    p array.my_reduce(:+)
    p array.my_reduce(10, :+)
  end

  def multiply_items(array)
    array.my_reduce
  end
end