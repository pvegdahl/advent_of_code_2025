defmodule AdventOfCode2025.Day11 do
  alias AdventOfCode2025.Cache
  alias AdventOfCode2025.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> count_paths("you", "out")
  end

  def parse_input(lines) do
    lines
    |> Enum.map(fn line ->
      [key, all_values] = String.split(line, ": ")
      values = String.split(all_values, " ")
      {key, values}
    end)
    |> Map.new()
  end

  defp count_paths(_graph, destination, destination), do: 1

  defp count_paths(graph, start, destination) do
    graph
    |> Map.get(start)
    |> Enum.map(fn node -> count_paths(graph, node, destination) end)
    |> Enum.sum()
  end

  def part_b(lines) do
    {:ok, cache} = Cache.init()

    lines
    |> parse_input()
    |> count_paths_with_required_nodes_and_caching("svr", "out", ["dac", "fft"], cache)
    |> Map.get([])
  end

  defp count_paths_with_required_nodes_and_caching(graph, start, destination, required_nodes, cache) do
    # Using just start as a cache key works as long as graph and destination are constant for a given cache.
    case Cache.get(cache, start) do
      nil ->
        result = count_paths_with_required_nodes(graph, start, destination, required_nodes, cache)
        Cache.put(cache, start, result)
        result

      result ->
        result
    end
  end

  defp count_paths_with_required_nodes(_graph, destination, destination, required_nodes, _cache) do
    %{required_nodes => 1}
  end

  defp count_paths_with_required_nodes(graph, start, destination, required_nodes, cache) do
    graph
    |> Map.get(start)
    |> Enum.flat_map(fn node ->
      intermediate_result = count_paths_with_required_nodes_and_caching(graph, node, destination, required_nodes, cache)

      if node in required_nodes do
        Enum.map(intermediate_result, fn {still_required_nodes, count} ->
          {List.delete(still_required_nodes, node), count}
        end)
      else
        Map.to_list(intermediate_result)
      end
    end)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Map.update(acc, key, value, fn existing_value -> existing_value + value end)
    end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_b()
  end
end
