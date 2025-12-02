defmodule AdventOfCode2025.Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day01

  test "Day01 part A example" do
    assert Day01.part_a(example_input()) == 3
  end

  defp example_input() do
    """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day01 part B example" do
    assert Day01.part_b(example_input()) == 42
  end
end
