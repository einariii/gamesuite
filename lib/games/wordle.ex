defmodule Games.Wordle do
  @moduledoc """
  Basic wordle to learn testing techniques.
  """
  def play do
    answer = Enum.random(["toast", "tarts", "hello", "beats"])
    guess = IO.gets("Enter a five letter word:")

    feedback(answer, guess)
  end

  def feedback(answer, guess) do
    guess_list = String.split(guess, "", trim: true)
    answer_list = String.split(answer, "", trim: true)

    # guess_count = Enum.frequencies(guess_list)
    # answer_count = Enum.frequencies(answer_list)

    zipped_list = Enum.zip(guess_list, answer_list)

    Enum.map(zipped_list, fn {guess_char, answer_char} ->
      # Enum.reduce(guess_count, 0, fn elem, acc -> acc + 1 end)
      cond do
        guess_char not in answer_list -> :grey
        guess_char == answer_char -> :green
        # guess_char in answer_list and guess_char
        true -> :yellow
      end
    end)
  end
end
