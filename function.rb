#!/usr/bin/env ruby

  
def initialize_search string
  @array = s              
  @array.size.times do |spot|
    @spot = spot
    @reach = 1
    even_palindromes
    odd_palindromes
  end
end

def even_palindromes
  while @array[@spot - @reach + 1] == @array[@spot + @reach]
    unless @spot - @reach  < 0
      @palindromes << @array[@spot - @reach + 1, @reach * 2].join
    end
    @reach += 1
  end
end

def odd_palindromes
  while @array[@spot - @reach] == @array[@spot + @reach]
    unless @spot - @reach + 1 < 0
      @palindromes << @array[@spot - @reach, @reach * 2 + 1].join 
    end
    @reach += 1
  end
end

def return_results
  return "No palindromes found." if @palindromes.empty?
  puts "The longest found was the #{longest.length} character palindrome: #{longest}"
  puts "The total number of unique palindromes identified: #{@palindromes.uniq.size}"
  @palindromes.uniq.sort.sort_by &:size
end

def longest
  @palindromes.max_by &:size
end
