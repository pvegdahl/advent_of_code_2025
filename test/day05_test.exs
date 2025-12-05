defmodule AdventOfCode2025.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day05

  test "Day05 part A example" do
    assert Day05.part_a(example_input()) == 3
  end

  defp example_input() do
    """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "Day05 part B example" do
    assert Day05.part_b(example_input()) == 14
  end
end
