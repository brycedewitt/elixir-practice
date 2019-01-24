defmodule Practice.Calc do

  # This will input text and output it parsed as a float
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/) # This line chunks the text, based on spaces, into a collection
    |> hd # delegated the mappings of :num and :op to a helper function
    |> parse_float
    |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def palindrome?(x) do
    x = String.replace(x, " ", "")
    x = String.downcase(x)

    if x == String.reverse(x) do
      true
      else
        false
    end
  end

  # This takes a collection comprised of the 4 basic math operators and numbers, and
  # maps them to a Keyword List
  def tag_tokens(x) do
    Enum.map(x, fn(y) -> {determineAtom(y), y} end)
  end

  def determineAtom(x) do
    if is_float(x) || is_integer(x) do
      :num
      else
      :op
    end
  end


  # Factoring functions are down here
  def factor(number, currentFactor, primeFactors) when number < currentFactor do
    primeFactors
  end

  # can't use modulo in guard, using rem()
  def factor(number, currentFactor, primeFactors) when rem(number, currentFactor) == 0 do
    x = div(number,currentFactor)
    y = primeFactors ++ [currentFactor]
    factor(x, currentFactor, y)
  end

  def factor(number, currentFactor, primeFactors) do
    x = currentFactor + 1
    factor(number, x, primeFactors)
  end



end
