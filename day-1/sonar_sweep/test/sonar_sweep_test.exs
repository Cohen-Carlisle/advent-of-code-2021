defmodule SonarSweepTest do
  use ExUnit.Case
  doctest SonarSweep

  describe "#count_increases/1" do
    test "counts the increases correctly" do
      measurements =
        "test/fixtures/depth_measurements.txt"
        |> File.read!()
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)

      assert SonarSweep.count_increases(measurements) == 1832
    end
  end
end
