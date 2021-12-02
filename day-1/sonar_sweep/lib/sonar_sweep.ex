defmodule SonarSweep do
  @moduledoc """
  A module for performing real live sonar sweeps of the sea floor.
  """

  @doc """
  Calculates the number of increases from the previous measurement over all
  elements in a list. If given a window, compares the sum of the sliding window.

  ## Examples

      iex> SonarSweep.count_increases([1, 2, 3])
      2
      iex> SonarSweep.count_increases([3, 2, 1])
      0
      iex> SonarSweep.count_increases([1, 2, 2, 3, 3])
      2
      iex> SonarSweep.count_increases([1, 2, 2, 3, 3], 2)
      3

  """
  def count_increases(depths, window \\ 1) do
    depths
    |> Enum.chunk_every(window + 1, 1, :discard)
    |> Enum.count(&(List.last(&1) > List.first(&1)))
  end
end
