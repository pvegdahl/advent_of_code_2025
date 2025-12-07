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

  describe "next_line_a/3" do
    test "one that splits, one that does not" do
      row = 2
      beams = MapSet.new([5, 10])
      splitters = MapSet.new([{5, 2}, {9, 2}, {11, 2}, {10, 3}])

      assert Day07.next_line_a(beams, splitters, row) == {MapSet.new([4, 6, 10]), 1}
    end
  end

  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == 40
  end

  describe "next_line_b/3" do
    test "two that split into the same beam sum the count" do
      row = 2
      beams = %{2 => 1, 4 => 2, 8 => 6, 12 => 3}
      splitters = MapSet.new([{2, 2}, {4, 2}, {12, 2}, {8, 3}])

      assert Day07.next_line_b(beams, splitters, row) == %{1 => 1, 3 => 3, 5 => 2, 8 => 6, 11 => 3, 13 => 3}
    end
  end
end
