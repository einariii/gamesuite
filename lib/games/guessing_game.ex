defmodule Games.GuessingGame do
  @moduledoc """
  Read a computer's mind! Guess the number it's thinking.
  """

  @doc """
  This function generates a random number between 1 and 10,
  and then calls the interactive play function.
  """
  @spec play() :: nil | :ok
  def play do
    answer = Enum.random(1..10)
    # |> IO.inspect()
    play_io(answer)
  end

  @doc """
  This function compares user input with the computer's number, and allocates one of three outputs
  to be output by the subsequent function.
  """
  @spec check(integer(), integer()) :: String.t()
  def check(guess, answer) do
    cond do
      guess == answer ->
        "CORRECT! Now treat yourself to a nice fresh #{Enum.random(["🥑", "🍌", "🍍", "🍋", "🍊", "🍉", "🍒", "🍓"])}"

      guess > answer ->
        "Too high!"

      guess < answer ->
        "Too low!"
    end
  end

  @doc """
  This function retrieves the user's guess and calls the function to evaluate it.
  If the guess is too high or too low, it recursively calls itself again.
  If the user's guess matches the computer's number, it redirects the user to the main Games menu.
  """
  @spec play_io(integer()) :: :ok
  def play_io(answer) do
    {guess, _rest} =
      IO.gets(
        IO.ANSI.light_yellow_background() <>
        IO.ANSI.bright <>
        "\nWhat number am I thinking of? Guess from 1 to 10: "
        <> IO.ANSI.reset()
      )
      |> Integer.parse()

    result = check(guess, answer)
    IO.puts(IO.ANSI.white_background <> result <> IO.ANSI.reset())

    if guess == answer do
      retry()
    else
      play_io(answer)
    end
  end

  def retry do
    reply = IO.gets(IO.ANSI.black_background <> "\nTry again? (y/n): " <> IO.ANSI.reset)
    |> String.trim()
    |> String.downcase()

    if reply == "y" do
      play()
    else
      Games.Menu.display()
    end
  end
end




# unless guess == answer do
    #   play_io(answer)
    # end
