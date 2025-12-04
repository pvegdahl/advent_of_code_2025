defmodule AdventOfCode2025.Day04 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.Grid

  def part_a(lines) do
    lines
    |> Grid.parse_string_grid()
    |> Map.get("@")
    |> accessible_points()
    |> Enum.count()
  end

  defp accessible_points(points) do
    points
    |> Enum.map(&count_neighbors(&1, points))
    |> Enum.filter(fn {_point, point_count} -> point_count < 4 end)
    |> Enum.map(fn {point, _point_count} -> point end)
  end

  defp count_neighbors(point, points) do
    point_count =
      point
      |> Grid.candidate_neighbors_with_diagonals()
      |> Enum.filter(&MapSet.member?(points, &1))
      |> Enum.count()

    {point, point_count}
  end

  def part_b(lines) do
    points = Grid.parse_string_grid(lines) |> Map.get("@")
    final_points = keep_pruning(points)

    Enum.count(points) - Enum.count(final_points)
  end

  defp keep_pruning(points) do
    pruned_points = prune_points(points)

    if points == pruned_points do
      points
    else
      keep_pruning(pruned_points)
    end
  end

  defp prune_points(points) do
    MapSet.difference(points, MapSet.new(accessible_points(points)))
  end

  def a() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_b()
  end
end
