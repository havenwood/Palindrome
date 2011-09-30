#!/usr/bin/env ruby
require "minitest/autorun"
require "minitest/pride"

module PalindromeFinder
  def search string
    initialize_palindromes string
    find_palindromes
    return_palindromes
  end

  private
  
  def initialize_palindromes string
    @array = string.to_s.downcase.gsub(/[^0-9a-z]/, '').split ''
    @@palindromes = []
  end
  
  def find_palindromes
    @array.size.times do |spot|
      @spot = spot
      find_even_palindromes
      find_odd_palindromes      
    end
  end
  
  def return_palindromes
    return "No palindromes found." if @@palindromes.empty?
    @@palindromes.uniq.sort.sort_by &:size
  end
  
  def find_even_palindromes
    @reach = 1
    while @array[looking_here_before] == @array[looking_forward]
      unless looking_here_before < 0 || @reach == 1
        @@palindromes << @array[looking_here_before, @reach * 2].join
      end
      @reach += 1
    end
  end
  
  def find_odd_palindromes
    @reach = 1
    while @array[looking_back] == @array[looking_forward]
      unless looking_back < 0
        @@palindromes << @array[looking_back, @reach * 2 + 1].join
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

class Palindrome; end
Palindrome.extend PalindromeFinder

class TestPalindrome < MiniTest::Unit::TestCase
  def setup
    @text = 'FourscoreandsevenyearsagoourfaathersbroughtforthonthiscontainentanewnationconceivedinzLibertyanddedicatedtothepropositionthatallmenarecreatedequalNowweareengagedinagreahtcivilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth'
  end
  
  def test_that_when_search_has_a_match_it_returns_an_array
    result = Palindrome.search @text
    assert_kind_of Array, result
  end
  
  def test_that_search_finds_palindromes_from_a_long_string
    result = Palindrome.search @text
    assert result.include?("ala")
    assert result.include?("edde")
    assert result.include?("heseh")
  end
  
  def test_that_search_handles_spaces_in_text
    result = Palindrome.search "h  e ye   h"
    assert_equal ["eye", "heyeh"], result
  end
  
  def test_that_search_detects_even_and_odd_palindromes_together
    result = Palindrome.search "yetteyahat"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_search_detects_odd_palindromes
    result = Palindrome.search "aha"
    assert_equal ["aha"], result
  end
  
  def test_that_search_detects_even_palindromes
    result = Palindrome.search "ahha"
    assert_equal ["ahha"], result
  end
  
  def test_that_search_strips_non_text_characters
    result = Palindrome.search "My life close twice--before its close. Ye. Tte! Y?"
    assert_equal ["ebe", "eye", "ette", "yettey"], result
  end
  
  def test_that_search_responds_when_none_found
    result = Palindrome.search "nopalindromesinthisstring"
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_responds_to_empty_string
    result = Palindrome.search ""
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_does_not_loop_past_beginning_of_array_for_false_positives
    assert Palindrome.search("x0xx0x0xx0x0xx0x").all? { |word| word.length > 2 }
  end
  
  def test_that_search_does_not_loop_past_end_of_array_for_false_positive
    result = Palindrome.search "yetteyaha"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_search_detects_numeric_palindromes
    result = Palindrome.search "49012345432183"
    assert_equal ["454", "34543", "2345432", "123454321"], result
  end
end