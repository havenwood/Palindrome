#!/usr/bin/env ruby
require "rubygems"
gem "minitest"
require "minitest/autorun"
require "minitest/pride"

class Palindrome
  def search string
    @array = string.gsub(/[^0-9a-z ]/i, '').gsub(' ', '').downcase.split ''
    @palindromes = []
    find_palindromes
    @palindromes.empty? and return "No palindromes found."
    @palindromes = @palindromes.uniq.sort.sort_by &:size
  end

  def longest
    @palindromes.is_a?(Array) or return "You must search for palindromes before you can find the longest."
    @palindromes.empty? and return "You must find a palindrome before the longest can be determined."
    @palindromes.max_by &:size
  end

  private

  def find_palindromes
    @array.size.times do |spot|
      @spot = spot
      @palindromes = @palindromes
      find_even_palindromes
      find_odd_palindromes      
    end
  end
  
  def find_even_palindromes
    @reach = 1
    while @array[looking_back + 1] == @array[looking_forward]
      @palindromes << @array[looking_back + 1, @reach * 2].join unless @reach == 1 || looking_back + 1 < 0
      @reach += 1
    end
  end
  
  def find_odd_palindromes
    @reach = 1
    while @array[looking_back] == @array[looking_forward]
      @palindromes << @array[looking_back, @reach * 2 + 1].join unless looking_back < 0
      @reach += 1
    end
  end

  def looking_forward
    @spot + @reach
  end

  def looking_back
    @spot - @reach
  end
  
end

class TestPalindrome < MiniTest::Unit::TestCase
  def setup
    @palindrome = Palindrome.new
    @text = 'FourscoreandsevenyearsagoourfaathersbroughtforthonthiscontainentanewnationconceivedinzLibertyanddedicatedtothepropositionthatallmenarecreatedequalNowweareengagedinagreahtcivilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth'
  end
  
  def test_that_when_search_has_a_match_it_returns_an_array
    result = @palindrome.search @text
    assert_kind_of Array, result
  end
  
  def test_that_search_finds_palindromes_from_a_long_string
    result = @palindrome.search @text
    assert result.include?("ala")
    assert result.include?("edde")
    assert result.include?("heseh")
  end
  
  def test_that_search_handles_spaces_in_text
    result = @palindrome.search "h  e ye   h"
    assert_equal ["eye", "heyeh"], result
  end
  
  def test_that_search_detects_even_and_odd_palindromes_together
    result = @palindrome.search "yetteyahat"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_search_detects_odd_palindromes
    result = @palindrome.search "aha"
    assert_equal ["aha"], result
  end
  
  def test_that_search_detects_even_palindromes
    result = @palindrome.search "ahha"
    assert_equal ["ahha"], result
  end
  
  def test_that_search_strips_non_text_characters
    result = @palindrome.search "My life close twice--before its close. Ye. Tte! Y?"
    assert_equal ["ebe", "eye", "ette", "yettey"], result
  end
  
  def test_that_search_responds_when_none_found
    result = @palindrome.search "nopalindromesinthisstring"
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_responds_to_empty_string
    result = @palindrome.search ""
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_does_not_loop_past_beginning_of_array_for_false_positives
    assert @palindrome.search("x0xx0x0xx0x0xx0x").all? { |word| word.length > 2 }
  end
  
  def test_that_search_does_not_loop_past_end_of_array_for_false_positive
    result = @palindrome.search "yetteyaha"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_longest_finds_matching_string
    @palindrome.search @text
    assert_equal "ranynar", @palindrome.longest
  end

  def test_that_longest_responds_without_search
    assert_equal "You must search for palindromes before you can find the longest.", @palindrome.longest
  end
end