defmodule AdventOfCode2025.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.Day09

  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == 50
  end

  defp example_input() do
    """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day09 part B example" do
    assert Day09.part_b(example_input()) == 24
  end

  #  describe "contains?/2" do
  #    test "easily contained" do
  #      polygon = [{0, 0}, {10, 0}, {10, 10}, {0, 10}]
  #      rectangle = {{2, 2}, {6, 6}}
  #
  #      assert Day09.contains?(polygon, rectangle)
  #    end
  #
  #    test "easily not contained" do
  #      polygon = [{0, 0}, {10, 0}, {10, 10}, {0, 10}]
  #      rectangle = {{12, 12}, {16, 16}}
  #
  #      refute Day09.contains?(polygon, rectangle)
  #    end
  #  end

  describe "point_in_polygon?/2" do
    setup do
      %{the_u: [{0, 0}, {10, 0}, {10, 10}, {8, 10}, {8, 2}, {2, 2}, {2, 10}, {0, 10}]}
    end

    test "simple inside" do
      polygon = [{0, 0}, {10, 0}, {10, 10}, {0, 10}]

      assert Day09.point_in_polygon?(polygon, {5, 5}, 10)
    end

    test "outside the U", %{the_u: the_u} do
      refute Day09.point_in_polygon?(the_u, {5, 5}, 10)
    end

    test "inside the U", %{the_u: the_u} do
      assert Day09.point_in_polygon?(the_u, {1, 5}, 10)
      assert Day09.point_in_polygon?(the_u, {9, 5}, 10)
      assert Day09.point_in_polygon?(the_u, {5, 1}, 10)
    end

    test "on a vertical edge of the U", %{the_u: the_u} do
      assert Day09.point_in_polygon?(the_u, {0, 5}, 10)
      assert Day09.point_in_polygon?(the_u, {2, 5}, 10)
      assert Day09.point_in_polygon?(the_u, {8, 2}, 10)
      assert Day09.point_in_polygon?(the_u, {10, 10}, 10)
    end

    test "on a horizontal edge of the U", %{the_u: the_u} do
      assert Day09.point_in_polygon?(the_u, {5, 0}, 10)
      assert Day09.point_in_polygon?(the_u, {1, 10}, 10)
      assert Day09.point_in_polygon?(the_u, {5, 2}, 10)
      assert Day09.point_in_polygon?(the_u, {9, 10}, 10)
    end
  end
end
