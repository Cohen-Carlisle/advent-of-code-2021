defmodule SonarSweepTest do
  use ExUnit.Case
  doctest SonarSweep

  describe "#count_increases/2" do
    test "counts the increases correctly with no window" do
      measurements =
        "test/fixtures/depth_measurements.txt"
        |> File.read!()
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      assert SonarSweep.count_increases(measurements) == 1832
    end

    test "counts the increases correctly with a window of 3" do
      measurements =
        "test/fixtures/depth_measurements.txt"
        |> File.read!()
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      assert SonarSweep.count_increases(measurements, 3) == 1858
    end

    test "returns 0 for an empty list" do
      assert SonarSweep.count_increases([]) == 0
    end
  end
end
