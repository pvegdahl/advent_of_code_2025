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

  test "Day02 part B example" do
    assert Day02.part_b(example_input()) == 4_174_379_265
  end

  describe "invalid_for_any_chunk_size?/1" do
    test "565656 is invalid at chunks of 2" do
      assert Day02.invalid_for_any_chunk_size?(565_656)
    end

    test "single digits are not invalid" do
      refute Day02.invalid_for_any_chunk_size?(7)
    end
  end
end
