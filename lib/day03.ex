defmodule AdventOfCode2025.Day03 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    battery_banks = parse_input(lines)

    # In our puzzle input, all banks are the same size
    bank_size =
      battery_banks
      |> List.first()
      |> Enum.count()

    battery_banks
    |> Enum.map(&max_joltage(&1, bank_size, 2))
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

  defp max_joltage(_battery_bank, _bank_size, 0 = _num_to_take), do: 0

  defp max_joltage(battery_bank, bank_size, num_to_take) do
    max_next_value =
      battery_bank
      |> Stream.take(bank_size + 1 - num_to_take)
      |> Enum.max()

    max_index = Enum.find_index(battery_bank, &(&1 == max_next_value))
    remaining_bank = Enum.drop(battery_bank, max_index + 1)
    remaining_bank_size = bank_size - max_index - 1
    remaining_num_to_take = num_to_take - 1

    Integer.pow(10, remaining_num_to_take) * max_next_value +
      max_joltage(remaining_bank, remaining_bank_size, num_to_take - 1)
  end

  def part_b(lines) do
    battery_banks = parse_input(lines)

    # In our puzzle input, all banks are the same size
    bank_size =
      battery_banks
      |> List.first()
      |> Enum.count()

    battery_banks
    |> Enum.map(&max_joltage(&1, bank_size, 12))
    |> Enum.sum()
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
