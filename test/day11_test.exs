defmodule AdventOfCode2025.Day11Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day11

  test "Day11 part A example" do
    assert Day11.part_a(example_input_a()) == 5
  end

  defp example_input_a() do
    """
    aaa: you hhh
    you: bbb ccc
    bbb: ddd eee
    ccc: ddd eee fff
    ddd: ggg
    eee: out
    fff: out
    ggg: out
    hhh: ccc fff iii
    iii: out
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "example_input_a" do
      assert Day11.parse_input(example_input_a()) == %{
               "aaa" => ["you", "hhh"],
               "you" => ["bbb", "ccc"],
               "bbb" => ["ddd", "eee"],
               "ccc" => ["ddd", "eee", "fff"],
               "ddd" => ["ggg"],
               "eee" => ["out"],
               "fff" => ["out"],
               "ggg" => ["out"],
               "hhh" => ["ccc", "fff", "iii"],
               "iii" => ["out"]
             }
    end
  end

  test "Day11 part B example" do
    assert Day11.part_b(example_input_b()) == 2
  end

  defp example_input_b() do
    """
    svr: aaa bbb
    aaa: fft
    fft: ccc
    bbb: tty
    tty: ccc
    ccc: ddd eee
    ddd: hub
    hub: fff
    eee: dac
    dac: fff
    fff: ggg hhh
    ggg: out
    hhh: out
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end
end
