#!/usr/bin/env ruby
class Palindrome
  def search string
    @array = string.downcase.split ''
    @array.size.times do |spot|
      @spot = spot
      find_palindromes
    end
    return "No palindromes found." if @palindromes.nil?
    @palindromes = @palindromes.uniq.sort_by &:size
  end

  def longest
    return "You must search for and find a palindrome before you can find the longest." unless @palindromes.is_a?(Array)
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

require 'minitest/autorun'

class TestPalindrome < MiniTest::Unit::TestCase
  def setup
    @palindrome = Palindrome.new
    @text = 'FourscoreandsevenyearsagoourfaathersbroughtforthonthiscontainentanewnationconceivedinzLibertyanddedicatedtothepropositionthatallmenarecreatedequalNowweareengagedinagreahtcivilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth'
  end
  
  def test_that_search_finds_palindromes
    result = @palindrome.search @text
    assert_equal ["eve", "nen", "ded", "tot", "opo", "iti", "ata", "ede", "gag", "ivi", "ono", "nyn", "epe", "nun", "oco", "ewe", "asa", "hoh", "ere", "ehe", "ese", "ara", "dad", "lll", "nin", "eme", "mem", "tit", "did", "ini", "hth", "ofo", "ala", "illli", "hereh", "anyna", "heseh", "ranynar"], result
  end
  
  def test_that_search_handles_no_matches
    result = @palindrome.search "nopalindromesinthisstring"
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_does_not_loop_back_and_return_one_or_two_letter_false_positives
    result = @palindrome.search("x0xx0x0xx0x0xx0x").all? { |word| word.length > 2 }
    assert_equal true, result
  end
  
  def test_that_longest_finds_matching_string
    @palindrome.search @text
    assert_equal "ranynar", @palindrome.longest
  end

  def test_that_longest_on_an_empty_array_plays_nice
    assert_equal "You must search for and find a palindrome before you can find the longest.", @palindrome.longest
  end
end