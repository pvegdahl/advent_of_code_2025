defmodule AdventOfCode2025.Day01 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.scan(50, fn {direction, amount}, acc ->
      case direction do
        :+ -> Integer.mod(acc + amount, 100)
        :- -> Integer.mod(acc - amount, 100)
      end
    end)
    |> Enum.count(&(&1 == 0))
  end

  defp parse_input(lines) do
    Enum.map(lines, &parse_one_line/1)
  end

  defp parse_one_line(line) do
    {direction, num} =
      line
      |> String.trim()
      |> String.split_at(1)

    {direction_string_to_atom(direction), String.to_integer(num)}
  end

  defp direction_string_to_atom("R"), do: :+
  defp direction_string_to_atom("L"), do: :-

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day01.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day01.txt")
    |> part_b()
  end
end
