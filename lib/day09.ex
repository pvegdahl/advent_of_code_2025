defmodule AdventOfCode2025.Day09 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Helpers.pairs()
    |> Enum.map(&rectangle_size/1)
    |> Enum.max()
  end

  defp parse_input(lines) do
    Enum.map(lines, fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  defp rectangle_size({{x0, y0}, {x1, y1}}) do
    dx = abs(x1 - x0) + 1
    dy = abs(y1 - y0) + 1

    dx * dy
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_b()
  end
end
