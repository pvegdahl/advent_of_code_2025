defmodule AdventOfCode2025.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day04

  test "Day04 part A example" do
    assert Day04.part_a(example_input()) == 13
  end

  defp example_input() do
    """
    ..xx.xx@x.
    x@@.@.@.@@
    @@@@@.x.@@
    @.@@@@..@.
    x@.@@@@.@x
    .@@@@@@@.@
    .@.@.@.@@@
    x.@@@.@@@@
    .@@@@@@@@.
    x.x.@@@.x.
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day04 part B example" do
    assert Day04.part_b(example_input()) == 42
  end
end
