defmodule AdventOfCode2025.Day03 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    parse_input(lines)
    |> Enum.map(&max_joltage/1)
    |> Enum.sum()
  end

  defp parse_input(lines) do
    lines
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp max_joltage(battery_bank) do
    bank_size = Enum.count(battery_bank)

    max_first_value =
      battery_bank
      |> Stream.take(bank_size - 1)
      |> Enum.max()

    max_index = Enum.find_index(battery_bank, &(&1 == max_first_value))

    max_second_value =
      battery_bank
      |> Stream.drop(max_index + 1)
      |> Enum.max()

    10 * max_first_value + max_second_value
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day03.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day03.txt")
    |> part_b()
  end
end
