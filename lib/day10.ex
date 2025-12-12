defmodule AdventOfCode2025.Day10 do
  alias AdventOfCode2025.Helpers
  alias AdventOfCode2025.Queue

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.map(&min_presses_a/1)
    |> Enum.sum()
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [target_string, buttons_string, joltage_string] =
        line
        |> String.trim_leading("[")
        |> String.trim_trailing("}")
        |> String.split(~r/\] | {/)

      target =
        target_string
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.filter(fn {character, _index} -> character == "#" end)
        |> Enum.map(fn {_character, index} -> index end)
        |> indexes_to_integer()

      target_size = String.length(target_string)

      button_lists =
        buttons_string
        |> String.split(" ")
        |> Enum.map(fn group ->
          button_numbers =
            group
            |> String.trim_leading("(")
            |> String.trim_trailing(")")
            |> String.split(",")
            |> Enum.map(&String.to_integer/1)

          for i <- 0..(target_size - 1) do
            if Enum.member?(button_numbers, i) do
              1
            else
              0
            end
          end
        end)

      buttons =
        buttons_string
        |> String.split(" ")
        |> Enum.map(fn group ->
          group
          |> String.trim_leading("(")
          |> String.trim_trailing(")")
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> indexes_to_integer()
        end)

      joltage =
        joltage_string
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      %{
        target: target,
        buttons: buttons,
        button_lists: button_lists,
        joltage: joltage
      }
    end)
  end

  defp indexes_to_integer(indexes) do
    Enum.reduce(indexes, 0, fn index, acc -> acc + Integer.pow(2, index) end)
  end

  defp min_presses_a(stuff, state \\ 0)

  defp min_presses_a(%{target: target}, target), do: 0
  defp min_presses_a(%{buttons: []}, _), do: :infinity

  defp min_presses_a(%{target: target, buttons: [first_b | rest_b]}, state) do
    new_state = Bitwise.bxor(state, first_b)

    min_presses_from_new_state =
      case min_presses_a(%{target: target, buttons: rest_b}, new_state) do
        :infinity -> :infinity
        number -> number + 1
      end

    min_presses_without_new_state = min_presses_a(%{target: target, buttons: rest_b}, state)

    min(min_presses_from_new_state, min_presses_without_new_state)
  end

  def part_b(lines) do
    lines
    |> parse_input()
    |> Stream.map(&min_presses_b/1)
    |> Stream.each(&IO.inspect/1)
    |> Enum.sum()
  end

  defp min_presses_b(%{joltage: joltage, button_lists: button_lists}) do
    initial_state = %{joltage: joltage, button_lists: button_lists, count: 0}

    queue = Queue.new() |> Queue.push(initial_state)
    seen_joltages = MapSet.new()

    min_presses_b(queue, seen_joltages)
  end

  defp min_presses_b(%Queue{} = queue, seen_joltages) do
    {
      popped_queue,
      %{joltage: joltage, button_lists: button_lists, count: count}
    } = Queue.pop(queue)

    updated_count = count + 1

    results =
      button_lists
      |> sub_lists()
      |> Enum.map(fn [button_list | _] = sub_button_lists ->
        remaining_joltage = subtract_from_joltage(joltage, button_list)

        cond do
          Enum.any?(remaining_joltage, &(&1 < 0)) -> :failure
          Enum.all?(remaining_joltage, &(&1 == 0)) -> :success
          true -> {:continue, remaining_joltage, sub_button_lists}
        end
      end)
      |> Enum.reject(&(&1 == :failure))

    if Enum.any?(results, &(&1 == :success)) do
      updated_count
    else
      new_joltage_results =
        Enum.reject(results, fn {:continue, remaining_joltage, _sub_button_lists} ->
          MapSet.member?(seen_joltages, remaining_joltage)
        end)

      new_queue_items =
        new_joltage_results
        |> Enum.map(fn {:continue, remaining_joltage, sub_button_lists} ->
          %{joltage: remaining_joltage, button_lists: sub_button_lists, count: updated_count}
        end)

      new_queue = popped_queue |> Queue.push_many(new_queue_items)

      new_seen_joltages =
        Enum.map(new_joltage_results, fn {:continue, remaining_joltage, _sub_button_lists} -> remaining_joltage end)
        |> MapSet.new()
        |> MapSet.union(seen_joltages)

      min_presses_b(new_queue, new_seen_joltages)
    end
  end

  def sub_lists([_] = list), do: [list]

  def sub_lists([_head | tail] = list) do
    [list | sub_lists(tail)]
  end

  defp subtract_from_joltage(joltage, button_list) do
    Enum.zip_with(joltage, button_list, fn a, b -> a - b end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_b()
  end
end
