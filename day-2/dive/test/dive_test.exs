defmodule DiveTest do
  use ExUnit.Case
  doctest Dive

  test "performs a complicated dive" do
    output =
      File.read!("test/fixtures/dive_input.txt")
      |> Dive.parse_input()
      |> Dive.perform()

    assert output == 1_698_850_445
  end
end
