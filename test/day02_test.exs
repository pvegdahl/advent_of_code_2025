defmodule AdventOfCode2025.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day02

  test "Day02 part A example" do
    assert Day02.part_a(example_input()) == 1_227_775_554
  end

  defp example_input() do
    """
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
    1698522-1698528,446443-446449,38593856-38593862,565653-565659,
    824824821-824824827,2121212118-2121212124
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day02 part B example" do
    assert Day02.part_b(example_input()) == 42
  end
end
