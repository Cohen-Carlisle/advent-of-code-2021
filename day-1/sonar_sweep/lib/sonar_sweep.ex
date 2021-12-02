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
  def count_increases(depths, window \\ 1)
  def count_increases([], _), do: 0
  def count_increases(depths, window), do: do_count_increases(depths, window - 1, 0)

  # in this optimized recursive function, we need only compare the leftmost and rightmost
  # elements of the window. e.g., if the window is 3 and (a+b+c) < (b+c+d), then d > a
  # because you can subtract b and c from both sides. to compare the rightmost and leftmost
  # elements, we have to traverse (window + 1) elements, e.g., 4 in the previous example.
  # the leftmost element is always the head of the list. the rightmost is then the
  # (window + 1)th element. in implementation, this is the (window - 1) index of the tail.
  # e.g., with [1,2,3,4] and a window size of 3, left = 1, right = Enum.at([2,3,4], 2) = 4.
  # this is a very minor optimization not to traverse the head twice.
  #
  # ok, now that we have left and right, we need to check that we actually do have a right.
  # if right is nil, we ran out of elements to look at. this is the base case. return count.
  # else if right > left, recurse and increase the count, passing the tail.
  # else, recurse, do not incrase the count, and again pass the tail.
  defp do_count_increases([left | tail], right_index, count) do
    right = Enum.at(tail, right_index)

    case {left, right} do
      {_left, nil} ->
        count

      {left, right} when right > left ->
        do_count_increases(tail, right_index, count + 1)

      _ ->
        do_count_increases(tail, right_index, count)
    end
  end
end
