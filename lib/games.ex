defmodule Games do
  @moduledoc """
  The entrance to the Games archive, aka the executable called ./games
  """

  @doc """
  This function is called when the Games escript is called. In turn, it calls the display function from the Menu module.
  """
  def main do
    Games.Menu.display()
  end
end
