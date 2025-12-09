defmodule AdventOfCode2025.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day09

  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == 50
  end

  defp example_input() do
    """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day09 part B example" do
    assert Day09.part_b(example_input()) == 42
  end
end
