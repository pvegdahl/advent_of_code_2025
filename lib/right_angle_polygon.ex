defmodule AdventOfCode2025.RightAnglePolygon do
  defstruct [:point_list, :verticals, :horizontals, :x_range, :y_range]

  def new(point_list) do
    {verticals, horizontals} = vertical_and_horizontal_line_maps(point_list)

    {min_x, max_x} = verticals |> Map.keys() |> Enum.min_max()
    {min_y, max_y} = horizontals |> Map.keys() |> Enum.min_max()

    %__MODULE__{
      point_list: point_list,
      verticals: verticals,
      horizontals: horizontals,
      x_range: min_x..max_x,
      y_range: min_y..max_y
    }
  end

  defp vertical_and_horizontal_line_maps(point_list) do
    groups =
      point_list
      |> Enum.chunk_every(2, 1, Enum.take(point_list, 1))
      |> Enum.group_by(fn [{x0, _y0}, {x1, _y1}] -> x0 == x1 end)

    verticals =
      groups
      |> Map.get(true, [])
      |> Enum.map(fn [{x, y0}, {x, y1}] ->
        [y00, y01] = Enum.sort([y0, y1])
        {x, y00..y01}
      end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    horizontals =
      groups
      |> Map.get(false, [])
      |> Enum.map(fn [{x0, y}, {x1, y}] ->
        [x00, x01] = Enum.sort([x0, x1])
        {y, x00..x01}
      end)
      |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))

    {verticals, horizontals}
  end

  def rectangle_inside?(%__MODULE__{} = polygon, {{x0, y0}, {x1, y1}} = _rectangle) do
    [min_x, max_x] = Enum.sort([x0, x1])
    [min_y, max_y] = Enum.sort([y0, y1])

    horizontal_line_inside?(polygon, min_x..max_x, min_y) and
      horizontal_line_inside?(polygon, min_x..max_x, max_y) and
      vertical_line_inside?(polygon, min_x, min_y..max_y) and
      vertical_line_inside?(polygon, max_x, min_y..max_y)
  end

  # This head always works, but it is inefficient as the x range grows
  def horizontal_line_inside?(%__MODULE__{} = polygon, x0..x1//1, y) when x1 - x0 < 8 do
    x0..x1
    |> Enum.map(&{&1, y})
    |> Enum.all?(&point_inside?(polygon, &1))
  end

  def horizontal_line_inside?(%__MODULE__{} = polygon, x0..x1//1, y) do
    x_range = (x0 + 2)..(x1 - 2)

    points_of_interest =
      polygon.verticals
      |> Map.keys()
      |> Enum.filter(&(&1 in x_range))
      |> Enum.flat_map(&[&1 - 1, &1 + 1])
      |> Enum.concat([x0, x0 + 1, x1 - 1, x1])
      |> Enum.uniq()
      |> Enum.map(&{&1, y})

    Enum.all?(points_of_interest, &point_inside?(polygon, &1))
  end

  # This head always works, but it is inefficient as the x range grows
  def vertical_line_inside?(%__MODULE__{} = polygon, x, y0..y1//1) when y1 - y0 < 8 do
    y0..y1
    |> Enum.map(&{x, &1})
    |> Enum.all?(&point_inside?(polygon, &1))
  end

  def vertical_line_inside?(%__MODULE__{} = polygon, x, y0..y1//1) do
    y_range = (y0 + 2)..(y1 - 2)

    points_of_interest =
      polygon.horizontals
      |> Map.keys()
      |> Enum.filter(&(&1 in y_range))
      |> Enum.flat_map(&[&1 - 1, &1 + 1])
      |> Enum.concat([y0, y0 + 1, y1 - 1, y1])
      |> Enum.uniq()
      |> Enum.map(&{x, &1})

    Enum.all?(points_of_interest, &point_inside?(polygon, &1))
  end

  def point_inside?(%__MODULE__{} = polygon, point) do
    if point_on_edge?(polygon, point) do
      true
    else
      intersections = count_vertical_intersections(polygon, point)
      Integer.mod(intersections, 2) == 1
    end
  end

  defp point_on_edge?(polygon, point) do
    intersects_vertical?(polygon, point) or intersects_horizontal?(polygon, point)
  end

  defp intersects_vertical?(polygon, {x, y}) do
    case Map.get(polygon.verticals, x) do
      nil -> false
      ranges -> Enum.any?(ranges, fn range -> y in range end)
    end
  end

  defp intersects_horizontal?(polygon, {x, y}) do
    case Map.get(polygon.horizontals, y) do
      nil -> false
      ranges -> Enum.any?(ranges, fn range -> x in range end)
    end
  end

  defp count_vertical_intersections(polygon, {x, y}) do
    _..max_x//1 = polygon.x_range

    possible_xs =
      polygon.verticals
      |> Map.keys()
      |> Enum.filter(fn candidate_x -> candidate_x in x..max_x end)

    Enum.count(possible_xs, fn specific_x -> intersects_vertical?(polygon, {specific_x, y}) end)
  end
end
