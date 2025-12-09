defmodule AdventOfCode2025.Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day08

  test "Day08 part A example" do
    assert Day08.part_a(example_input(), 10) == 40
  end

  defp example_input() do
    """
    162,817,812
    57,618,57
    906,360,560
    592,479,940
    352,342,300
    466,668,158
    542,29,236
    431,825,988
    739,650,466
    52,470,668
    216,146,977
    819,987,18
    117,168,530
    805,96,715
    346,949,466
    970,615,88
    941,993,340
    862,61,35
    984,92,344
    425,690,689
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "Day08 part B example" do
    assert Day08.part_b(example_input()) == 25272
  end
end
