defmodule AdventOfCode2025.Day04 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.Grid

  def part_a(lines) do
    points = Grid.parse_string_grid(lines) |> Map.get("@")

    points
    |> Enum.map(&count_neighbors(&1, points))
    |> Enum.filter(fn {_point, point_count} -> point_count < 4 end)
    |> Enum.count()
  end

  defp count_neighbors(point, points) do
    point_count =
      point
      |> Grid.candidate_neighbors_with_diagonals()
      |> Enum.filter(&MapSet.member?(points, &1))
      |> Enum.count()

    {point, point_count}
  end

  def part_b(_lines) do
    -1
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
