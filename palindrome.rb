#!/usr/bin/env ruby

module FindPalindromes
  def find_odd_palindromes
    @reach = 1
    while @array[looking_back] == @array[looking_forward]
      unless looking_back < 0
        @palindromes << @array[looking_back, @reach * 2 + 1].join
      end
      @reach += 1
    end
  end
  
  def find_even_palindromes
    @reach = 1
    while @array[looking_here_before] == @array[looking_forward]
      unless looking_here_before < 0 || @reach == 1
        @palindromes << @array[looking_here_before, @reach * 2].join
      end
      @reach += 1
    end
  end
end

module Reach
  def looking_forward
    @spot + @reach
  end

  def looking_back
    @spot - @reach
  end

  def looking_here_before
    @spot - @reach + 1
  end
end

class PalindromeFinder
  class << self
    def search file
      initialize_palindromes file
      find_palindromes
      return_palindromes
    end

    private
  
    def initialize_palindromes file
      @array = IO.read(file).to_s.downcase.gsub(/[^0-9a-z]/, '').delete('\n').split ''
      @palindromes = []
    end
    
    include FindPalindromes
    include Reach
  
    def find_palindromes
      @array.size.times do |spot|
        @spot = spot
        find_odd_palindromes
        find_even_palindromes
      end
    end
        
    def return_palindromes
      return "No palindromes found." if @palindromes.empty?
      @palindromes.uniq.sort.sort_by &:size
    end
  end
end

filename = ARGV.first
fail "./palindrome.rb [file ...]" if filename.nil?
puts PalindromeFinder.search filename