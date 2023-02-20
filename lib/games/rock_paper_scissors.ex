defmodule Games.RockPaperScissors do
  @moduledoc """
  Rudimentary Rock Paper Scissors game written in Elixir.
  """
  @winners [{"rock", "scissors"}, {"scissors", "paper"}, {"paper", "rock"}]
  @acceptable_plays ["rock", "paper", "scissors"]

  @doc """
  This function generates an AI play, grabs a user play using the IO module, determines the winner, and outputs the result.

  iex> Games.RockPaperScissors.play()
  (rock/paper/scissors):
  """
  @spec play() :: nil | :ok
  def play do
    ai_play = Enum.random(["rock", "paper", "scissors"])

    user_play =
      IO.gets(IO.ANSI.red_background <> "\nPick your poison! (rock/paper/scissors): " <> IO.ANSI.reset())
      |> String.trim()
      |> String.downcase()

    cond do
      user_play not in @acceptable_plays ->
        IO.puts(~s[LOL you seriously played "#{user_play}"? Game over, my friend, GAME OVER.])
        retry()

      user_play == ai_play ->
        IO.puts("It's a tie!")
        retry()

      {user_play, ai_play} in @winners ->
        IO.puts(
          IO.ANSI.white_background() <>
          "You win! #{user_play} beats #{ai_play}. So, have a bite of #{Enum.random(["🥑", "🍌", "🍍", "🍋", "🍊", "🍉", "🍒", "🍓"])}"
          <> IO.ANSI.reset()
        )

        retry()

      true ->
        IO.puts("You lose! #{ai_play} beats #{user_play}.")
        retry()
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
