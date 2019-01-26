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
    |> tag_tokens # delegated the mappings of :num and :op to a helper function
    |> convert_to_postfix([], [])
    |> reverse_to_prefix
    |> evaluate_as_stack([])

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  # might pipe this later if I have time
  def palindrome?(x) do

    # first, cleaning up the input (remove spaces and caps)
    y = String.replace(x, " ", "")
    z = String.downcase(y)

    # this is the logic to figure out if palindrome
    z == String.reverse(z)
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

  def convert_to_postfix(infix_list, op_stack, final_collection) when infix_list != [] do
    first_in_list = List.first(infix_list)
    removed_first = List.delete_at(infix_list, 0)

    if hd(Tuple.to_list(first_in_list)) == :op do
      IO.puts("Processing operation in primary function")
      handle_operator(first_in_list, removed_first, op_stack, final_collection)
    else
      # 1. Print operands as they arrive.
      IO.puts("Processing number in primary function")
      final_collection_plus_num = final_collection ++ [first_in_list]
      convert_to_postfix(removed_first, op_stack, final_collection_plus_num)
    end
    end

  def convert_to_postfix(infix_list, op_stack, final_collection) when infix_list == [] do
    final_collection
  end

  # 2. If the stack is empty, push the incoming operator onto the stack.
  def handle_operator(first_in_list, infix_list, op_stack, final_collection) when op_stack == [] do
    IO.puts("empty op stack function called")
    x = op_stack ++ first_in_list
    convert_to_postfix(infix_list, x, final_collection)
  end

  def handle_operator(first_in_list, infix_list, op_stack, final_collection) when op_stack != [] do
    a = length([op_stack])
    operator = tl(Tuple.to_list(first_in_list))
    first_operator_in_stack = tl(Tuple.to_list(op_stack))
    IO.puts(operator  ++ first_operator_in_stack)

    cond do
    # 3. If the incoming symbol has equal precedence with the top of the stack, use association (left to right)
      ((operator == "+") || (operator == "-")) && ((first_operator_in_stack == "+") || (first_operator_in_stack == "-")) ->
      y = tl(op_stack) ++  first_in_list
      x = final_collection ++ first_in_list
      convert_to_postfix(infix_list, y, x)

    # 3. If the incoming symbol has equal precedence with the top of the stack, use association (left to right)
      ((operator == "*") || (operator == "/")) && ((first_operator_in_stack == "*") || (first_operator_in_stack == "/")) ->
      y = tl(op_stack) ++  first_in_list
      x = final_collection ++ first_in_list
      convert_to_postfix(infix_list, y, x)

    # 4. If the incoming symbol has higher precedence than the top of the stack, push it on the stack.
      ((operator == "*") || (operator == "/")) && ((first_operator_in_stack == "+") || (first_operator_in_stack == "-")) ->
      y = op_stack ++  first_in_list
      convert_to_postfix(infix_list, y, final_collection)

    # 5. If the incoming symbol has lower precedence than the symbol on the top of the stack, pop the stack and print
    #    the top operator. Then test the incoming operator against the new top of stack
      ((operator == "-") || (operator == "+")) && ((first_operator_in_stack == "*") || (first_operator_in_stack == "/")) ->
       x = final_collection ++ first_in_list
       y = hd(tl(op_stack))
       z = tl(op_stack)
       handle_operator(y, infix_list, z, x)
      true ->
        IO.puts("Error in handle_operator")
      end

    end


    # reverses postfix to prefix
  def reverse_to_prefix(x) do
      Enum.reverse(x)
  end

  # this is the stack calculator base case.  Returns only number in stack.
  def evaluate_as_stack(x, stack) when x == [] do
    tl(Tuple.to_list(Enum.at(0)))
  end

  # this is the actual stack calculator
  def evaluate_as_stack(x, stack) when x != [] do
    first_in_list = List.first(x)
    removed_first = List.delete_at(x, 0)
    as_text = hd(Tuple.to_list(first_in_list))

    # push numbers to stack when spotted
    if as_text == :num do
      x = stack ++ first_in_list
      evaluate_as_stack(removed_first, x)
    else
    # operate on previous 2 numbers when come across an operator
      first = tl(Tuple.to_list(Enum.at(stack, 0)))
      second = tl(Tuple.to_list(Enum.at(stack, 1)))
      new = Enum.drop(stack, 2)
      operate_on_expression(first, second, as_text, x, new)
    end
  end

  # helper function for stack calculator, evaluates expressions
  def operate_on_expression(x, y, operation, input, stack) do
    out = 1

       case operation do
          "+" ->
            out = x + y
          "*" ->
            out = x * y
          "-" ->
            out = x - y
           "/" ->
            out = x / y
            _ ->
          end
          new_stack = stack ++ out

          evaluate_as_stack(input, new_stack)

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
