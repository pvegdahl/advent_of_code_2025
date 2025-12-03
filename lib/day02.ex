defmodule AdventOfCode2025.Day02 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Stream.concat()
    |> Stream.filter(&invalid_part_a?/1)
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

  defp invalid_part_a?(num) do
    num_string = Integer.to_string(num)
    size = String.length(num_string)

    if Integer.mod(size, 2) == 0 do
      chunk_size = Integer.floor_div(size, 2)
      invalid_for_chunks_of?(num_string, chunk_size)
    else
      false
    end
  end

  def part_b(lines) do
    lines
    |> parse_input()
    |> Stream.concat()
    |> Stream.filter(&invalid_for_any_chunk_size?/1)
    |> Enum.sum()
  end

  defp invalid_for_chunks_of?(num_string, chunk_size) do
    size = String.length(num_string)

    if Integer.mod(size, chunk_size) != 0 do
      false
    else
      [front | rest] = string_chunk_by(num_string, chunk_size)
      Enum.all?(rest, &(&1 == front))
    end
  end

  defp string_chunk_by(string, chunk_size) do
    if String.length(string) <= chunk_size do
      [string]
    else
      {front_chunk, rest} = String.split_at(string, chunk_size)
      [front_chunk | string_chunk_by(rest, chunk_size)]
    end
  end

  def invalid_for_any_chunk_size?(num) do
    num_string = Integer.to_string(num)
    size = String.length(num_string)

    if size == 1 do
      false
    else
      max_chunk_size = Integer.floor_div(size, 2)
      Enum.any?(1..max_chunk_size, &invalid_for_chunks_of?(num_string, &1))
    end
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
