defmodule AdventOfCode2025.Day05 do
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    {fresh_ranges, ingredient_list} = parse_input(lines)

    Enum.count(ingredient_list, &is_fresh?(&1, fresh_ranges))
  end

  defp parse_input(lines) do
    {fresh_range_strings, [_ | ingredient_list_strings]} = Enum.split_while(lines, &(&1 != ""))

    fresh_ranges =
      fresh_range_strings
      |> Enum.map(fn fresh_range_string ->
        [a, b] =
          fresh_range_string
          |> String.split("-")
          |> Enum.map(&String.to_integer/1)

        a..b
      end)

    ingredient_list = Enum.map(ingredient_list_strings, &String.to_integer/1)

    {fresh_ranges, ingredient_list}
  end

  defp is_fresh?(ingredient, fresh_ranges), do: Enum.any?(fresh_ranges, &(ingredient in &1))

  def part_b(lines) do
    {fresh_ranges, _ingredient_list} = parse_input(lines)

    fresh_ranges
    |> merge_all_ranges()
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp merge_all_ranges(ranges) do
    Enum.reduce(ranges, [], fn range, acc ->
      merge_new_range(range, acc)
    end)
  end

  defp merge_new_range(new_range, ranges) do
    Enum.reduce(ranges, [new_range], fn range, [newest_range | tail] ->
      maybe_merge_ranges(newest_range, range) ++ tail
    end)
  end

  defp maybe_merge_ranges(range1, range2) do
    if Range.disjoint?(range1, range2) do
      [range1, range2]
    else
      a1..b1//_ = range1
      a2..b2//_ = range2
      [min(a1, a2)..max(b1, b2)]
    end
  end

  def a() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_b()
  end
end
