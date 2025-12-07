defmodule AdventOfCode2025.Day07 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.Grid

  def part_a(lines) do
    {start_x, splitters} = parse_input(lines)

    {_beams, count} = run_the_machine_a(start_x, splitters)
    count
  end

  defp run_the_machine_a(start_x, splitters) do
    max_row = max_row(splitters)

    Enum.reduce(1..max_row, {MapSet.new([start_x]), 0}, fn row, {beams, count} ->
      {new_beams, added_count} = next_line_a(beams, splitters, row)

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

  def next_line_a(beams, splitters, row) do
    beams_split = MapSet.filter(beams, fn beam_x -> MapSet.member?(splitters, {beam_x, row}) end)
    added_beams = Enum.flat_map(beams_split, fn beam -> [beam - 1, beam + 1] end) |> MapSet.new()

    new_beams =
      beams
      |> MapSet.difference(beams_split)
      |> MapSet.union(added_beams)

    {new_beams, MapSet.size(beams_split)}
  end

  def part_b(lines) do
    {start_x, splitters} = parse_input(lines)

    run_the_machine_b(start_x, splitters)
    |> Map.values()
    |> Enum.sum()
  end

  defp run_the_machine_b(start_x, splitters) do
    max_row = max_row(splitters)

    Enum.reduce(1..max_row, %{start_x => 1}, fn row, beams -> next_line_b(beams, splitters, row) end)
  end

  def next_line_b(beams, splitters, row) do
    beams_split = Map.filter(beams, fn {beam_x, _count} -> MapSet.member?(splitters, {beam_x, row}) end)
    added_beams = Enum.flat_map(beams_split, fn {beam, count} -> [{beam - 1, count}, {beam + 1, count}] end)

    beams_minus_splits = Map.drop(beams, Map.keys(beams_split))

    Enum.reduce(added_beams, beams_minus_splits, fn {beam_x, count}, new_beams ->
      Map.update(new_beams, beam_x, count, fn old_count -> old_count + count end)
    end)
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
