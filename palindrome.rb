#!/usr/bin/env ruby

class PalindromeFinder
  class << self
    def search string
      initialize_palindromes string
      find_palindromes
      return_palindromes
    end

    private
  
    def initialize_palindromes string
      @array = string.to_s.downcase.gsub(/[^0-9a-z]/, '').split ''
      @palindromes = []
    end
  
    def find_palindromes
      @array.size.times do |spot|
        @spot = spot
        @reach = 1
        find_even_palindromes
        find_odd_palindromes      
      end
    end
  
    def return_palindromes
      return "No palindromes found." if @palindromes.empty?
      @palindromes.uniq.sort.sort_by &:size
    end
  
    def find_even_palindromes
      while @array[looking_here_before] == @array[looking_forward]
        unless looking_here_before < 0 || @reach == 1
          @palindromes << @array[looking_here_before, @reach * 2].join
        end
        @reach += 1
      end
    end
  
    def find_odd_palindromes
      while @array[looking_back] == @array[looking_forward]
        unless looking_back < 0
          @palindromes << @array[looking_back, @reach * 2 + 1].join
        end
        @reach += 1
      end
    end

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
end