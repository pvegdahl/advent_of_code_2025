defmodule AdventOfCode2025.Day06Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day06

  test "Day06 part A example" do
    assert Day06.part_a(example_input()) == 4_277_556
  end

  defp example_input() do
    """
    123 328  51 64
     45 64  387 23
      6 98  215 314
    *   +   *   +
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day06 part B example" do
    assert Day06.part_b(example_input()) == 42
  end
end
