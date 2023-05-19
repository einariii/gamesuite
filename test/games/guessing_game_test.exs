defmodule Games.GuessingGameTest do
  use ExUnit.Case

  # should the test name be the name of a function?
  # what about the principle of testing behavior, not implementation?
  # what needs testing?

  test "check/2" do
    assert Games.GuessingGame.check(9, 9) == "Correct!"
    assert Games.GuessingGame.check(8, 6) == "Too high!"
    assert Games.GuessingGame.check(2, 4) == "Too low!"
  end
end
