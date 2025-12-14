defmodule AdventOfCode2025.Day11 do
  alias AdventOfCode2025.Helpers

  def part_a(_lines) do
    -1
  end

  def parse_input(lines) do
    lines
    |> Enum.map(fn line ->
      [key, all_values] = String.split(line, ": ")
      values = String.split(all_values, " ")
      {key, values}
    end)
    |> Map.new()
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_b()
  end
end
