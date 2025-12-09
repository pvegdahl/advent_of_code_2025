defmodule AdventOfCode2025.Day08 do
  alias AdventOfCode2025.Helpers

  def part_a(lines, connection_count) do
    points = parse_input(lines)

    closest_point_pairs =
      points
      |> pairs()
      |> Enum.sort_by(fn {point0, point1} -> distance_squared(point0, point1) end)
      |> Enum.take(connection_count)

    group_points(points, closest_point_pairs)
    |> Map.values()
    |> Enum.uniq()
    |> Enum.map(&Enum.count/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp parse_input(lines) do
    lines
    |> Enum.map(&Helpers.string_to_int_list(&1, ","))
    |> Enum.map(&List.to_tuple/1)
  end

  defp distance_squared({x0, y0, z0}, {x1, y1, z1}) do
    dx = x1 - x0
    dy = y1 - y0
    dz = z1 - z0

    dx * dx + dy * dy + dz * dz
  end

  def pairs(list) do
    list_as_tuple = List.to_tuple(list)
    max_index = tuple_size(list_as_tuple) - 1

    for i <- 0..(max_index - 1), j <- (i + 1)..max_index do
      {elem(list_as_tuple, i), elem(list_as_tuple, j)}
    end
  end

  defp group_points(points, point_pairs) do
    initial_groups = Map.new(points, &{&1, MapSet.new([&1])})

    Enum.reduce(point_pairs, initial_groups, fn {point0, point1}, groups ->
      group0 = Map.get(groups, point0)
      group1 = Map.get(groups, point1)
      new_group = MapSet.union(group0, group1)

      new_entries = Map.new(new_group, fn point -> {point, new_group} end)
      Map.merge(groups, new_entries)
    end)
  end

  def part_b(lines) do
    points = parse_input(lines)

    sorted_point_pairs =
      points
      |> pairs()
      |> Enum.sort_by(fn {point0, point1} -> distance_squared(point0, point1) end)

    {{x0, _y0, _z0}, {x1, _y1, _z1}} = last_pair_to_connect_everything(points, sorted_point_pairs)

    x0 * x1
  end

  defp last_pair_to_connect_everything(points, sorted_point_pairs) do
    target_size = Enum.count(points)

    initial_groups = Map.new(points, &{&1, MapSet.new([&1])})

    Enum.reduce_while(sorted_point_pairs, initial_groups, fn {point0, point1}, groups ->
      group0 = Map.get(groups, point0)
      group1 = Map.get(groups, point1)
      new_group = MapSet.union(group0, group1)

      if MapSet.size(new_group) == target_size do
        {:halt, {point0, point1}}
      else
        new_entries = Map.new(new_group, fn point -> {point, new_group} end)
        {:cont, Map.merge(groups, new_entries)}
      end
    end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_a(1000)
  end

  def b() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_b()
  end
end
