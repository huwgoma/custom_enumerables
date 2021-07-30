require 'pry'
require_relative 'tests'
require 'colorize'

include Testable

module Enumerable 
  def enum
    Enumerator.new(self)
  end

  def my_each
    return enum unless block_given?
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
    return enum unless block_given?
    enum_type = self.class

    i = 0 
    loop do 
      yield(self[i], i) if enum_type == Array
      yield([self.keys[i], self.values[i]], i) if enum_type == Hash
      i+=1
      break if i > self.length - 1
    end
    self
  end

  def my_select
    return enum unless block_given?
    enum_type = self.class
    return_value = enum_type == Array ? [] : {}
    
    i = 0
    loop do 
      if enum_type == Array
        return_value.push(self[i]) if yield(self[i])
      elsif enum_type == Hash
        return_value[self.keys[i]] = self.values[i] if yield(self.keys[i], self.values[i])
      end
      i+=1
      break if i > self.length - 1
    end
    return_value
  end

  def my_all?(pattern = (arg_not_passed = true; nil), &block)
    enum_type = self.class
    arg_passed = !arg_not_passed
    
    if arg_passed
      puts "#{block.source_location.join(':')}: warning: given block not used" if block_given?
      block = Proc.new { |object| pattern === object }
    elsif !block_given?
      block = Proc.new { |object| object }
    end

    i = 0 
    loop do 
      returned_value = block.call(self[i]) if enum_type == Array
      returned_value = block.call(self.keys[i], self.values[i]) if enum_type == Hash
      return false unless returned_value
      i+=1
      break if i > self.length - 1 
    end
    true
  end

  def my_any?(pattern = (arg_not_passed = true; nil), &block)
    enum_type = self.class
    arg_passed = !arg_not_passed

    i = 0 
    loop do 
      returned_value = block.call(self[i]) if enum_type == Array
      returned_value = block.call(self.keys[i], self.values[i]) if enum_type == Hash
      return true if returned_value
      i+=1
      break if i > self.length - 1 
    end
    false
  end
end

numbers = [1,2,3,4,5]
hash = { a: 'a value', b: 'b value', c: 'c value' }

test_my_any?(numbers, hash)

# binding.pry
puts 'end'.bold