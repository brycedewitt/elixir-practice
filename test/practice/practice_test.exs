ExUnit.start()

defmodule Practice.PracticeTest do
  use ExUnit.Case
  import Practice

  test "double some numbers" do
    assert double(4) == 8
    assert double(3.5) == 7.0
    assert double(21) == 42
    assert double(0) == 0
  end

  test "factor some numbers" do
    assert factor(5) == [5]
    assert factor(8) == [2,2,2]
    assert factor(12) == [2,2,3]
    assert factor(226037113) == [3449, 65537]
    assert factor(1575) == [3,3,5,5,7]
  end

  test "evaluate some expressions" do
    assert calc("5") == 5
    assert calc("5 + 1") == 6
    assert calc("5 * 3") == 15
    assert calc("10 / 2") == 5
    assert calc("10 - 2") == 8
    assert calc("5 * 3 + 8") == 23
    assert calc("8 + 5 * 3") == 23
  end

  # TODO: (done) Add two unit tests for palindrome.

  # palindrome function is case & space insensitive for UTF-8 characters
  test "test some palindromes" do
    assert palindrome?("sonos") == true # checks for a true palindrome
    assert palindrome?("bose") == false # checks for a false palindrome
    assert palindrome?("10001") == true # checks that numbers are also palindromes
    assert palindrome?("@tuut@") == true # checks that symbols can also be a palindrome
    assert palindrome?("a santa at nasa") == true # checks a multi-word palindrome
    assert palindrome?("A santa at NASA") == true # checks that capitalization doesn't matter
    assert palindrome?("") == true # checks that an empty string is a palindrome (as stated in a paper online)
    assert palindrome?("πσπ") == true # checks non-standard UTF-8 characters
  end
end
