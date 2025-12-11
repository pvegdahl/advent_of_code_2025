defmodule AdventOfCode2025.Day10 do
  alias AdventOfCode2025.Helpers

  def part_a(_lines) do
    -1
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [lights_string, buttons_string, _joltage_string] =
        line
        |> String.trim_leading("[")
        |> String.trim_trailing("}")
        |> String.split(~r/\] | {/)

      lights =
        lights_string
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.filter(fn {character, _index} -> character == "#" end)
        |> Enum.map(fn {_character, index} -> index end)
        |> indexes_to_integer()

      buttons =
        buttons_string
        |> String.split(" ")
        |> Enum.map(fn group ->
          group
          |> String.trim_leading("(")
          |> String.trim_trailing(")")
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> indexes_to_integer()
        end)

      %{
        lights: lights,
        buttons: buttons,
        joltage: :todo
      }
    end)
  end

  defp indexes_to_integer(indexes) do
    Enum.reduce(indexes, 0, fn index, acc -> acc + Integer.pow(2, index) end)
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_b()
  end
end
