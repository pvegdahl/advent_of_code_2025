defmodule AdventOfCode2025.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day10

  test "Day10 part A example" do
    assert Day10.part_a(example_input()) == 7
  end

  defp example_input() do
    """
    [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    [...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
    [.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day10 part B example" do
    assert Day10.part_b(example_input()) == 42
  end
end
