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
    |> Enum.reduce([count: 0, previous: [], window: window], &do_count_increases/2)
    |> Keyword.fetch!(:count)
  end

  defp do_count_increases(current, [count: 0, previous: previous, window: window]) when length(previous) < window do
    [count: 0, previous: [current | previous], window: window]
  end

  defp do_count_increases(current, [count: count, previous: previous, window: window]) do
    new_previous = [current | Enum.slice(previous, 0..-2)]
    previous_sum = Enum.sum(previous)
    current_sum = Enum.sum(new_previous)

    if current_sum > previous_sum do
      [count: count + 1, previous: new_previous, window: window]
    else
      [count: count, previous: new_previous, window: window]
    end
  end
end
