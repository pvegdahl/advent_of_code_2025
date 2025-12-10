defmodule AdventOfCode2025.Day09 do
  alias AdventOfCode2025.Helpers

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

  def part_b(_lines) do
    -1
  end

  #  def contains?(polygon, {{x0, y0}, {x1, y1}} = _rectangle) do
  #    {min_x, max_x} = polygon |> Enum.map(&elem(&1, 0)) |> Enum.min_max()
  #    {min_y, max_y} = polygon |> Enum.map(&elem(&1, 1)) |> Enum.min_max()
  #
  #    # So dumb!
  #    x1 < max_x
  #  end

  def point_in_polygon?(polygon, point, max_x) do
    {verticals, horizontals} = vertical_and_horizontal_line_maps(polygon)

    if point_on_edge?(verticals, horizontals, point) do
      true
    else
      intersections = count_vertical_intersections(verticals, point, max_x)
      Integer.mod(intersections, 2) == 1
    end
  end

  defp point_on_edge?(verticals, horizontals, point) do
    intersects_vertical?(verticals, point) or intersects_horizontal?(horizontals, point)
  end

  defp intersects_vertical?(verticals, {x, y}) do
    case Map.get(verticals, x) do
      nil -> false
      ranges -> Enum.any?(ranges, fn range -> y in range end)
    end
  end

  defp intersects_horizontal?(horizontals, {x, y}) do
    case Map.get(horizontals, y) do
      nil -> false
      ranges -> Enum.any?(ranges, fn range -> x in range end)
    end
  end

  defp count_vertical_intersections(verticals, {x, y}, max_x) do
    Enum.count(x..max_x, fn specific_x -> intersects_vertical?(verticals, {specific_x, y}) end)
  end

  defp vertical_and_horizontal_line_maps(polygon) do
    groups =
      polygon
      |> Enum.chunk_every(2, 1, Enum.take(polygon, 1))
      |> Enum.group_by(fn [{x0, _y0}, {x1, _y1}] -> x0 == x1 end)

    vertical_map =
      groups
      |> Map.get(true, [])
      |> Enum.map(fn [{x, y0}, {x, y1}] ->
        [y00, y01] = Enum.sort([y0, y1])
        {x, y00..y01}
      end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    horizontal_map =
      groups
      |> Map.get(false, [])
      |> Enum.map(fn [{x0, y}, {x1, y}] ->
        [x00, x01] = Enum.sort([x0, x1])
        {y, x00..x01}
      end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    {vertical_map, horizontal_map}
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
