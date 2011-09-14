#!/usr/bin/env ruby
require "rubygems"
gem "minitest"
require "minitest/autorun"
require "minitest/pride"

class Palindrome
  def search string
    @array = string.downcase.split ''
    @array.size.times do |spot|
      @spot = spot
      find_palindromes
    end
    @palindromes.nil? and return "No palindromes found."
    @palindromes = @palindromes.uniq.sort_by &:size
  end

  def longest
    @palindromes.is_a?(Array) or return "You must search for and find a palindrome before you can find the longest."
    @palindromes.max_by &:size
  end
  
  private
  
  def find_palindromes
    @reach = 1
    while @array[looking_forward] == @array[looking_back]
      @palindromes ||= []
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
  
  def test_that_search_finds_palindromes
    result = @palindrome.search @text
    assert_equal ["eve", "nen", "ded", "tot", "opo", "iti", "ata", "ede", "gag", "ivi", "ono", "nyn", "epe", "nun", "oco", "ewe", "asa", "hoh", "ere", "ehe", "ese", "ara", "dad", "lll", "nin", "eme", "mem", "tit", "did", "ini", "hth", "ofo", "ala", "illli", "hereh", "anyna", "heseh", "ranynar"], result
  end
  
  def test_that_search_responds_when_none_found
    result = @palindrome.search "nopalindromesinthisstring"
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_responds_to_empty_string
    result = @palindrome.search ""
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_does_not_loop_back_and_return_one_or_two_letter_false_positives
    assert @palindrome.search("x0xx0x0xx0x0xx0x").all? { |word| word.length > 2 }
  end
  
  def test_that_longest_finds_matching_string
    @palindrome.search @text
    assert_equal "ranynar", @palindrome.longest
  end

  def test_that_longest_responds_without_search
    assert_equal "You must search for and find a palindrome before you can find the longest.", @palindrome.longest
  end
end