defmodule Games.WordleTerminal do
  @moduledoc """
  Rudimentary Wordle TUI game, written in Elixir.
  """

  @doc """
  Call this function to commence interactive play via the terminal.
  An answer word is randomly chosen from a custom word list, and the user
  is prompted to enter their own guess.
  The two words are compared; the comparison function is called; and
  the results are output to the screen.
  User is redirected to the main Games menu upon guessing the answer word, or
  after the maximum number of allowed attempts (6).
  """
  @spec play(String.t() | nil, integer()) :: :ok | no_return()
  def play(answer \\ nil, attempts \\ 1) do
    answer =
      answer ||
        Enum.random([
          "ghost",
          "haiku",
          "juice",
          "green",
          "force",
          "japan",
          "melty",
          "glass",
          "india",
          "synth",
          "pluto",
          "codes",
          "twist",
          "drape",
          "burnt",
          "alien",
          "ocean",
          "power",
          "noise",
          "speak",
          "music",
          "front",
          "retro",
          "cloud",
          "jewel",
          "games",
          "reset",
          "bound",
          "being",
          "front",
          "preen",
          "mouth",
          "minty",
          "flash",
          "sharp",
          "break",
          "pulse",
          "close",
          "great",
          "rider",
          "flirt",
          "flame",
          "belly",
          "shift",
          "short",
          "broom",
          "xerox",
          "drums",
          "ports",
          "water",
          "weeds",
          "loser",
          "punks",
          "slang",
          "worth",
          "jelly",
          "camel",
          "quart",
          "prune",
          "alpha",
          "never",
          "vibes",
          "local"
        ])

    answer_list = String.split(answer, "", trim: true)

    guess =
      IO.gets(
        IO.ANSI.light_magenta_background() <>
        IO.ANSI.bright() <>
        "\nEnter a five letter word: "
        <> IO.ANSI.reset()
      )
      |> String.trim()
      |> String.downcase()

    guess_list = String.split(guess, "", trim: true)

    feedback(answer_list, guess_list) |> Kernel.inspect() |> IO.puts()

    cond do
      String.length(guess) != 5 ->
        IO.puts(
          IO.ANSI.cyan() <> "Your entry must be exactly five characters long." <> IO.ANSI.reset()
        )

        play(answer, attempts)

      guess == answer ->
        IO.puts(IO.ANSI.light_blue() <> "You win! That was the correct word." <> IO.ANSI.reset())

        IO.puts(
          IO.ANSI.white_background() <>
            "Here is a fruit as a reward: #{Enum.random(["🥑", "🍌", "🍍", "🍋", "🍊", "🍉", "🍒", "🍓"])}" <>
            IO.ANSI.reset()
        )

        retry()

      attempts == 6 ->
        IO.puts(~s[Game over. Six-attempt limit reached. Your word was "#{answer}".])
        retry()

      true ->
        play(answer, attempts + 1)
    end
  end

  @doc """
  This function compares each guess word with the answer word, and outputs a list of color :atoms
  that correspond to their accuracy.

  iex> Games.WordleTerminal.feedback(["a", "b", "c", "d", "e"], ["e", "d", "c", "b", "a"])
  [:yellow, :yellow, :yellow, :yellow, :yellow]

  iex> Games.WordleTerminal.feedback(["a", "a", "a", "a", "a"], ["a", "a", "a", "a", "b"])
  [:green, :green, :green, :green, :grey]
  """
  @spec feedback(list(), list()) :: list()
  def feedback(answer_list, guess_list) do
    zipped_list = Enum.zip(guess_list, answer_list)
    # |> IO.inspect()

    Enum.map(zipped_list, fn {guess_char, answer_char} ->
      cond do
        guess_char not in answer_list -> :grey
        guess_char == answer_char -> :green
        true -> :yellow
      end
    end)
  end

  # def colorize(color, guess_char) do
  #   case color do
  #     :grey -> IO.ANSI.light_black() <> guess_char
  #     :yellow -> IO.ANSI.yellow() <> guess_char
  #     :green -> IO.ANSI.green() <> guess_char
  #   end
  # end

  def retry do
    reply =
      IO.gets(IO.ANSI.black_background() <> "\nPlay again? (y/n): " <> IO.ANSI.reset())
      |> String.trim()
      |> String.downcase()

    if reply == "y" do
      play()
    else
      Games.Menu.display()
    end
  end
end
