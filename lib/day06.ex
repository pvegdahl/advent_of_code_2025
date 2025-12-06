defmodule AdventOfCode2025.Day06 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.map(&do_math/1)
    |> Enum.sum()
  end

  def parse_input(lines) do
    {number_lines, [operand_line]} = Enum.split(lines, -1)

    rotated_numbers = number_lines |> Enum.map(&Helpers.string_to_int_list/1) |> rotate_list_matrix()

    operands = String.split(operand_line, " ", trim: true) |> Enum.map(&String.to_existing_atom/1)

    Enum.zip(operands, rotated_numbers)
  end

  defp rotate_list_matrix(matrix) do
    tuple_matrix =
      matrix
      |> Enum.map(&List.to_tuple/1)
      |> List.to_tuple()

    y_size = tuple_size(tuple_matrix)
    x_size = tuple_size(elem(tuple_matrix, 0))

    for i <- 0..(x_size - 1) do
      for j <- 0..(y_size - 1) do
        elem(elem(tuple_matrix, j), i)
      end
    end
  end

  defp do_math({:+, numbers}), do: Enum.sum(numbers)
  defp do_math({:*, numbers}), do: Enum.product(numbers)

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_b()
  end
end
