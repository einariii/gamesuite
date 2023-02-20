defmodule Games.WordleTest do
  use ExUnit.Case

  test "feedback/2 input and output" do
    assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
    assert Games.Wordle.feedback("aaaaa", "aaaab") == [:green, :green, :green, :green, :grey]

    assert Games.Wordle.feedback("abdce", "edcba") == [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]

    assert Games.Wordle.feedback("aaaaa", "bbbbb") == [:grey, :grey, :grey, :grey, :grey]
    # assert Games.Wordle.feedback("aaabb", "xaaaa") == [:grey, :green, :green, :yellow, :grey]
  end
end
