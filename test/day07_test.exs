defmodule AdventOfCode2025.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day07

  test "Day07 part A example" do
    assert Day07.part_a(example_input()) == 21
  end

  defp example_input() do
    """
    .......S.......
    ...............
    .......^.......
    ...............
    ......^.^......
    ...............
    .....^.^.^.....
    ...............
    ....^.^...^....
    ...............
    ...^.^...^.^...
    ...............
    ..^...^.....^..
    ...............
    .^.^.^.^.^...^.
    ...............
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "next_line/3" do
    test "one that splits, one that does not" do
      row = 2
      beams = MapSet.new([5, 10])
      splitters = MapSet.new([{5, 2}, {9, 2}, {11, 2}, {10, 3}])

      assert Day07.next_line(beams, splitters, row) == {MapSet.new([4, 6, 10]), 1}
    end
  end

  @tag :skip
  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == 42
  end
end
