defmodule Dive do
  @moduledoc """
  Controls a submarine, enabling it go forward, go down, or go up.
  """

  @doc """
  Performs the actions and returns the position coordinates multiplied.

  ## Examples

      iex> Dive.perform([{:down, 3}, {:forward, 5}, {:up, 1}])
      10

  """
  def perform(actions), do: actions |> Enum.reduce({0, 0}, &do_perform/2) |> multiply()

  def do_perform({:forward, n}, {x, y}), do: {x, y + n}
  def do_perform({:down, n}, {x, y}), do: {x + n, y}
  def do_perform({:up, n}, {x, y}), do: {x - n, y}

  @doc """
  Parses input for the perform command. Takes a string and produces a list of tuples.
  Only allows down, forward, and up for direction.
  Only allows integers for distance.

  ## Examples

      iex> Dive.parse_input("down 2\\nforward 5\\nup 1\\n")
      [{:down, 2}, {:forward, 5}, {:up, 1}]

  """
  def parse_input(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_input_string/1)
  end

  defp parse_input_string(string), do: string |> String.split(" ") |> parse_input_list()

  defp parse_input_list(["forward", n]), do: {:forward, String.to_integer(n)}
  defp parse_input_list(["down", n]), do: {:down, String.to_integer(n)}
  defp parse_input_list(["up", n]), do: {:up, String.to_integer(n)}

  defp multiply({x, y}), do: x * y
end
