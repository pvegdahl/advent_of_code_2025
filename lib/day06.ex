defmodule AdventOfCode2025.Day06 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input_a()
    |> Enum.map(&do_math/1)
    |> Enum.sum()
  end

  def parse_input_a(lines) do
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

    x_size =
      tuple_matrix
      |> Tuple.to_list()
      |> Enum.map(&tuple_size/1)
      |> Enum.max()

    for i <- 0..(x_size - 1) do
      for j <- 0..(y_size - 1) do
        get_from_tuple_matrix(tuple_matrix, i, j)
      end
    end
  end

  defp get_from_tuple_matrix(tuple_matrix, x, y) do
    cond do
      y >= tuple_size(tuple_matrix) -> ""
      x >= tuple_size(elem(tuple_matrix, y)) -> ""
      true -> elem(elem(tuple_matrix, y), x)
    end
  end

  defp do_math({:+, numbers}), do: Enum.sum(numbers)
  defp do_math({:*, numbers}), do: Enum.product(numbers)

  def part_b(lines) do
    lines
    |> parse_input_b()
    |> Enum.map(&do_math/1)
    |> Enum.sum()
  end

  def parse_input_b(lines) do
    {number_lines, [operand_line]} = Enum.split(lines, -1)

    numbers =
      number_lines
      |> Enum.map(&String.graphemes/1)
      |> rotate_list_matrix()
      |> Enum.map(&Enum.join(&1, ""))
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn maybe_number_string ->
        case maybe_number_string do
          "" -> nil
          number_string -> String.to_integer(number_string)
        end
      end)
      |> Enum.chunk_by(&is_nil/1)
      |> Enum.reject(&(&1 == [nil]))
      |> Enum.map(&Enum.reverse/1)

    operands = String.split(operand_line, " ", trim: true) |> Enum.map(&String.to_existing_atom/1)

    Enum.zip(operands, numbers)
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
