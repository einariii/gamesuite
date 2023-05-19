defmodule Games.Menu do
  def display do
    IO.puts(IO.ANSI.blue_background() <> IO.ANSI.bright() <> "\nSelect a game!" <> IO.ANSI.reset())

    IO.puts(IO.ANSI.green() <>
    """

    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    """
    <> IO.ANSI.reset()
    )

    {choice, _rest} =
      IO.gets(IO.ANSI.green_background() <> "Enter a number:" <> IO.ANSI.reset())
      |> Integer.parse()

    case choice do
      1 -> Games.GuessingGame.play()
      2 -> Games.RockPaperScissors.play()
      3 -> Games.Wordle.play()
      _ ->
        IO.puts(IO.ANSI.light_cyan_background() <>
          IO.ANSI.yellow() <>
          "\n     !!!!!!!!!!!!!!INVALID INPUT!!!!!!!!!!!!!!!
                ***PLEASE ENTER THE NUMBER 1, 2, or 3.***"
        <> IO.ANSI.reset()
        )
        display()
    end
  end
end
