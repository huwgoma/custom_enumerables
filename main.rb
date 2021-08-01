require 'pry'
require_relative 'tests'
require 'colorize'

include Testable

module Enumerable 
  #Helper methods
  def enum(method)
    Enumerator.new(self, method)
  end
  
  def block_if_pattern_given(pattern)
    Proc.new { |object| pattern === object }
  end

  def default_block
    Proc.new { |object| object }
  end

  def block_not_used_warning(block)
    "#{block.source_location.join(':')}: warning: given block not used"
  end

  #Enumerables
  def my_each
    return enum(:my_each) unless block_given?
    
    i = 0
    while i < self.length
      self.is_a?(Array) ? yield(self[i]) : yield(self.keys[i], self.values[i])
      i+=1
    end
  end

  def my_each_with_index
    return enum(:my_each_with_index) unless block_given?

    i = 0 
    while i < self.length 
      self.is_a?(Array) ? yield(self[i], i) : yield([self.keys[i], self.values[i]], i)
      i+=1
    end
    self
  end

  def my_select(&block)
    return enum(:my_select) unless block_given?
    return_value = self.is_a?(Array) ? [] : {}

    case self
    when Array
      self.my_each { |item| return_value << item if block.call(item) }
    when Hash
      self.my_each { |k, v| return_value[k] = v if block.call(k, v)}
    end
    return_value
  end

  def my_all?(pattern = (arg_not_passed = true; nil), &block)
    arg_passed = !arg_not_passed
    if arg_passed 
      puts block_not_used_warning(block) if block_given?
      block = block_if_pattern_given(pattern)
    end
    block = default_block unless arg_passed || block 

    self.my_each { |item| return false unless block.call(item) } if self.is_a?(Array)
    self.my_each { |k,v| return false unless block.call(k, v) } if self.is_a?(Hash)
    true
  end

  def my_any?(pattern = (arg_not_passed = true; nil), &block)
    arg_passed = !arg_not_passed
    if arg_passed 
      puts block_not_used_warning(block) if block_given?
      block = block_if_pattern_given(pattern)
    end
    block = default_block unless arg_passed || block 

    self.my_each { |item| return true if block.call(item) } if self.is_a?(Array)
    self.my_each { |k, v| return true if block.call(k, v) } if self.is_a?(Hash)
    false
  end

  def my_none?(pattern = (arg_not_passed = true; nil), &block)
    arg_passed = !arg_not_passed
    if arg_passed 
      puts block_not_used_warning(block) if block_given?
      block = block_if_pattern_given(pattern)
    end
    block = default_block unless arg_passed || block 

    self.my_each { |item| return false if block.call(item) } if self.is_a?(Array)
    self.my_each { |k, v| return false if block.call(k, v) } if self.is_a?(Hash)
    true
  end

  def my_count(item = (arg_not_passed = true; nil), &block)
    arg_passed = !arg_not_passed
    return self.length unless block_given? || arg_passed 
    
    if arg_passed 
      puts block_not_used_warning(block) if block_given?
      block = block_if_pattern_given(item)
    end

    count = 0
    self.my_each { |item| count += 1 if block.call(item) }
    binding.pry


    i = 0
    count = 0
    while i < self.length
      returned_value = block.call(self[i]) if self.is_a?(Array)
      returned_value = block.call(self.keys[i], self.values[i]) if self.is_a?(Hash)
      count += 1 if returned_value
      i += 1
    end
    count
  end

  # def my_map(&block)
  #   return enum(:my_map) unless block_given?
  #   return_value = []
  #   i = 0
  #   while i < self.length 
  #     return_value << block.call(self[i]) if self.is_a?(Array)
  #     return_value << block.call(self.keys[i], self.values[i]) if self.is_a?(Hash)
  #     i += 1
  #   end
  #   return_value
  # end
  def my_map(proc = nil, &block)
    return enum(:my_map) unless proc.is_a?(Proc) || block_given?
    block = proc if proc 
    #binding.pry
    return_value = []
    i = 0
    while i < self.length 
      return_value << block.call(self[i]) if self.is_a?(Array)
      return_value << block.call(self.keys[i], self.values[i]) if self.is_a?(Hash)
      i += 1
    end
    return_value
  end


  def my_reduce(initial = (initial_not_given = true; nil),
    sym = (sym_not_given = true; nil), 
    &block)
    argument_given = initial || sym
    raise LocalJumpError.new('no block given') unless block_given? || argument_given

    if initial.is_a?(Symbol) && sym_not_given
      sym, initial = initial, sym
      initial_not_given = true; sym_not_given = nil
      block = -> (memo, obj) { memo.send(sym, obj) }
    elsif initial && sym
      block = -> (memo, obj) { memo.send(sym, obj) }
    end

    i = 0 
    if initial_not_given
      initial = self[0] 
      i += 1 
    end
    memo = initial
    while i < self.length
      obj = self.is_a?(Array) ? self[i] : [self.keys[i], self.values[i]]
      memo = block.call(memo, obj)
      i += 1
    end
    memo
  end
end

numbers = [2,4,5]
hash = { a: 'a value', b: 'b value', c: 'c value' }

test_my_none?(numbers, hash)

# binding.pry
puts 'end'.bold