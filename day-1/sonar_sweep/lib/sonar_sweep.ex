defmodule SonarSweep do
  @moduledoc """
  A module for performing real live sonar sweeps of the sea floor.
  """

  @doc """
  Calculates the number of increases from the previous measurement for all
  elements in a list.

  ## Examples

      iex> SonarSweep.count_increases([1, 2, 3])
      2
      iex> SonarSweep.count_increases([3, 2, 1])
      0
      iex> SonarSweep.count_increases([1, 2, 2, 1, 3, 5])
      3

  """
  def count_increases(depths) do
    depths
    |> Enum.reduce([count: 0], &do_count_increases/2)
    |> Keyword.fetch!(:count)
  end

  defp do_count_increases(current, [count: 0]) do
    [previous: current, count: 0]
  end

  defp do_count_increases(current, [previous: previous, count: count]) when current > previous do
    [previous: current, count: count + 1]
  end

  defp do_count_increases(current, [previous: _previous, count: count]) do
    [previous: current, count: count]
  end
end
