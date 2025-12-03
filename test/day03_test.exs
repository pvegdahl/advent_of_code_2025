defmodule AdventOfCode2025.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day03

  @tag :skip
  test "Day03 part A example" do
    assert Day03.part_a(example_input()) == 42
  end

  defp example_input() do
    """
    TODO
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day03 part B example" do
    assert Day03.part_b(example_input()) == 42
  end
end
