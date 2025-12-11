defmodule AdventOfCode2025.Day10 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.map(&min_presses/1)
    |> Enum.sum()
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [target_string, buttons_string, _joltage_string] =
        line
        |> String.trim_leading("[")
        |> String.trim_trailing("}")
        |> String.split(~r/\] | {/)

      target =
        target_string
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
        target: target,
        buttons: buttons,
        joltage: :todo
      }
    end)
  end

  defp indexes_to_integer(indexes) do
    Enum.reduce(indexes, 0, fn index, acc -> acc + Integer.pow(2, index) end)
  end

  defp min_presses(stuff, state \\ 0)

  defp min_presses(%{target: target}, target), do: 0
  defp min_presses(%{buttons: []}, _), do: :infinity

  defp min_presses(%{target: target, buttons: [first_b | rest_b]}, state) do
    new_state = Bitwise.bxor(state, first_b)

    min_presses_from_new_state =
      case min_presses(%{target: target, buttons: rest_b}, new_state) do
        :infinity -> :infinity
        number -> number + 1
      end

    min_presses_without_new_state = min_presses(%{target: target, buttons: rest_b}, state)

    min(min_presses_from_new_state, min_presses_without_new_state)
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
