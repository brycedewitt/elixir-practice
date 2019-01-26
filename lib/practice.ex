defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # This also delegates to lib/practice/calc.ex
    # To function recursively, will take in the factor, an accumulator, and the list of past factors
    x
    |> Practice.Calc.factor(2, [])
    |> Kernel.inspect # add some prettier stuff here later
  end

  # Delegates to the palindrome factor
  def palindrome?(x) do
    # Since we delegated the others, we'll delegate this too
    Practice.Calc.palindrome?(x)
  end

end
