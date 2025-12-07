defmodule AdventOfCode2025.Day07 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.Grid

  def part_a(lines) do
    {start_x, splitters} = parse_input(lines)

    {_beams, count} = run_the_machine(start_x, splitters)
    count
  end

  defp run_the_machine(start_x, splitters) do
    max_row = max_row(splitters)

    Enum.reduce(1..max_row, {MapSet.new([start_x]), 0}, fn row, {beams, count} ->
      {new_beams, added_count} = next_line(beams, splitters, row)

      {new_beams, count + added_count}
    end)
  end

  defp parse_input(lines) do
    grid = Grid.parse_string_grid(lines)

    {start_x, 0} = Map.get(grid, "S") |> Enum.at(0)
    splitters = Map.get(grid, "^")

    {start_x, splitters}
  end

  defp max_row(splitters) do
    splitters
    |> Enum.map(fn {_x, y} -> y end)
    |> Enum.max()
  end

  def next_line(beams, splitters, row) do
    beams_split = Enum.filter(beams, fn beam_x -> MapSet.member?(splitters, {beam_x, row}) end) |> MapSet.new()
    added_beams = Enum.flat_map(beams_split, fn beam -> [beam - 1, beam + 1] end) |> MapSet.new()

    new_beams =
      beams
      |> MapSet.difference(beams_split)
      |> MapSet.union(added_beams)

    {new_beams, MapSet.size(beams_split)}
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_b()
  end
end
