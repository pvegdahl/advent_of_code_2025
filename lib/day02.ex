defmodule AdventOfCode2025.Day02 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    ranges = lines |> parse_input()

    ranges
    |> Stream.concat()
    |> Stream.filter(&invalid?/1)
    |> Enum.sum()
  end

  defp parse_input(lines) do
    Enum.join(lines, "")
    |> String.split(",")
    |> Enum.map(fn range_string ->
      [a, b] =
        range_string
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      a..b
    end)
  end

  defp invalid?(num) do
    num_string = Integer.to_string(num)
    size = String.length(num_string)

    if Integer.mod(size, 2) == 1 do
      false
    else
      {front, back} = String.split_at(num_string, Integer.floor_div(size, 2))
      front == back
    end
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_b()
  end
end
