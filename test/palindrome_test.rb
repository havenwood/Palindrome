#!/usr/bin/env ruby
require "rubygems"
gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./palindrome.rb"

class TestPalindrome < MiniTest::Unit::TestCase
  def setup
    @text = 'FourscoreandsevenyearsagoourfaathersbroughtforthonthiscontainentanewnationconceivedinzLibertyanddedicatedtothepropositionthatallmenarecreatedequalNowweareengagedinagreahtcivilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth'
  end
  
  def test_that_when_search_has_a_match_it_returns_an_array
    result = PalindromeFinder.search @text
    assert_kind_of Array, result
  end
  
  def test_that_search_finds_palindromes_from_a_long_string
    result = PalindromeFinder.search @text
    assert result.include?("ala")
    assert result.include?("edde")
    assert result.include?("heseh")
  end
  
  def test_that_search_handles_spaces_in_text
    result = PalindromeFinder.search "h  e ye   h"
    assert_equal ["eye", "heyeh"], result
  end
  
  def test_that_search_detects_even_and_odd_palindromes_together
    result = PalindromeFinder.search "yetteyahat"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_search_detects_odd_palindromes
    result = PalindromeFinder.search "aha"
    assert_equal ["aha"], result
  end
  
  def test_that_search_detects_even_palindromes
    result = PalindromeFinder.search "ahha"
    assert_equal ["ahha"], result
  end
  
  def test_that_search_strips_non_text_characters
    result = PalindromeFinder.search "My life close twice--before its close. Ye. Tte! Y?"
    assert_equal ["ebe", "eye", "ette", "yettey"], result
  end
  
  def test_that_search_responds_when_none_found
    result = PalindromeFinder.search "nopalindromesinthisstring"
    assert_equal "No palindromes found.", result
  end
  
  def test_that_search_responds_to_empty_string
    result = PalindromeFinder.search ""
    assert_equal "No palindromes found.", result
  end
  
  def test_three_digit_fixnum_palindromes
    result = PalindromeFinder.search 333
    assert_equal "333", result
  end
  
  def test_that_search_does_not_loop_past_beginning_of_array_for_false_positives
    assert PalindromeFinder.search("x0xx0x0xx0x0xx0x").all? { |word| word.length > 2 }
  end
  
  def test_that_search_does_not_loop_past_end_of_array_for_false_positive
    result = PalindromeFinder.search "yetteyaha"
    assert_equal ["aha", "ette", "yettey"], result
  end
  
  def test_that_search_detects_numeric_palindromes
    result = PalindromeFinder.search "49012345432183"
    assert_equal ["454", "34543", "2345432", "123454321"], result
  end
end