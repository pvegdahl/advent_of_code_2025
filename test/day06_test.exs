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
  end

  describe "parse_input_a/1" do
    test "example input" do
      assert Day06.parse_input_a(example_input()) == [
               {:*, [123, 45, 6]},
               {:+, [328, 64, 98]},
               {:*, [51, 387, 215]},
               {:+, [64, 23, 314]}
             ]
    end
  end

  test "Day06 part B example" do
    assert Day06.part_b(example_input()) == 3_263_827
  end

  describe "parse_input_b/1" do
    test "example input" do
      assert Day06.parse_input_b(example_input()) == [
               {:*, [356, 24, 1]},
               {:+, [8, 248, 369]},
               {:*, [175, 581, 32]},
               {:+, [4, 431, 623]}
             ]
    end
  end
end
