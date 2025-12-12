defmodule AdventOfCode2025.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day10

  test "Day10 part A example" do
    assert Day10.part_a(example_input()) == 7
  end

  test "part A one line" do
    assert Day10.part_a(example_input() |> Enum.take(1)) == 2
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

  describe "parse_input/1" do
    test "examples " do
      assert [
               %{
                 target: 0b0110,
                 buttons: [0b1000, 0b1010, 0b0100, 0b1100, 0b0101, 0b0011],
                 button_lists: [[0, 0, 0, 1], [0, 1, 0, 1], [0, 0, 1, 0], [0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]],
                 joltage: [3, 5, 4, 7]
               },
               %{
                 target: 0b01000,
                 buttons: _,
                 button_lists: _,
                 joltage: [7, 5, 12, 7, 2]
               },
               %{
                 target: 0b101110,
                 buttons: _,
                 button_lists: _,
                 joltage: [10, 11, 11, 5, 10, 5]
               }
             ] = Day10.parse_input(example_input())
    end
  end

  test "Day10 part B example" do
    assert Day10.part_b(example_input()) == 33
  end
end
