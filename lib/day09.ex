defmodule AdventOfCode2025.Day09 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.RightAnglePolygon

  def part_a(lines) do
    lines
    |> parse_input()
    |> Helpers.pairs()
    |> Enum.map(&rectangle_size/1)
    |> Enum.max()
  end

  defp parse_input(lines) do
    Enum.map(lines, fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end

  defp rectangle_size({{x0, y0}, {x1, y1}}) do
    dx = abs(x1 - x0) + 1
    dy = abs(y1 - y0) + 1

    dx * dy
  end

  def part_b(lines) do
    points = parse_input(lines)
    polygon = RightAnglePolygon.new(points)

    points
    |> Helpers.pairs()
    |> Enum.sort_by(&rectangle_size/1, :desc)
    |> Stream.chunk_every(500)
    |> Task.async_stream(
      fn chunk -> Enum.filter(chunk, &RightAnglePolygon.rectangle_inside?(polygon, &1)) end,
      ordered: true,
      timeout: :infinity
    )
    |> Stream.map(fn {:ok, result} -> result end)
    |> Stream.concat()
    |> Enum.take(1)
    |> then(fn [rectangle] -> rectangle_size(rectangle) end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_b()
  end
end
