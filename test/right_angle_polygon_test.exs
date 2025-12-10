defmodule AdventOfCode2025.RightAnglePolygonTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2025.RightAnglePolygon

  defp setup_u(_) do
    %{u: RightAnglePolygon.new([{0, 0}, {10, 0}, {10, 10}, {8, 10}, {8, 2}, {2, 2}, {2, 10}, {0, 10}])}
  end

  defp setup_h(_) do
    %{
      h:
        RightAnglePolygon.new([
          {0, -10},
          {2, -10},
          {2, -2},
          {8, -2},
          {8, -10},
          {10, -10},
          {10, 10},
          {8, 10},
          {8, 2},
          {2, 2},
          {2, 10},
          {0, 10}
        ])
    }
  end

  describe "point_inside?/2" do
    setup [:setup_u, :setup_h]

    test "simple inside" do
      polygon = RightAnglePolygon.new([{0, 0}, {10, 0}, {10, 10}, {0, 10}])

      assert RightAnglePolygon.point_inside?(polygon, {5, 5})
    end

    test "outside the U", %{u: u} do
      refute RightAnglePolygon.point_inside?(u, {5, 5})
    end

    test "inside the U", %{u: u} do
      assert RightAnglePolygon.point_inside?(u, {1, 5})
      assert RightAnglePolygon.point_inside?(u, {9, 5})
      assert RightAnglePolygon.point_inside?(u, {5, 1})
    end

    test "on a vertical edge of the U", %{u: u} do
      assert RightAnglePolygon.point_inside?(u, {0, 5})
      assert RightAnglePolygon.point_inside?(u, {2, 5})
      assert RightAnglePolygon.point_inside?(u, {8, 2})
      assert RightAnglePolygon.point_inside?(u, {10, 10})
    end

    test "on a horizontal edge of the U", %{u: u} do
      assert RightAnglePolygon.point_inside?(u, {5, 0})
      assert RightAnglePolygon.point_inside?(u, {1, 10})
      assert RightAnglePolygon.point_inside?(u, {5, 2})
      assert RightAnglePolygon.point_inside?(u, {9, 10})
    end

    test "on a line in the H", %{h: h} do
      assert RightAnglePolygon.point_inside?(h, {2, -5})
      assert RightAnglePolygon.point_inside?(h, {2, 5})
      assert RightAnglePolygon.point_inside?(h, {8, -5})
      assert RightAnglePolygon.point_inside?(h, {8, 5})
    end

    test "outside the H", %{h: h} do
      refute RightAnglePolygon.point_inside?(h, {5, 5})
      refute RightAnglePolygon.point_inside?(h, {5, -5})
    end
  end

  describe "horizontal_line_inside?/4" do
    setup :setup_h

    test "simple inside the h", %{h: h} do
      assert RightAnglePolygon.horizontal_line_inside?(h, 3, 7, 0)
    end

    test "simple outside the h", %{h: h} do
      refute RightAnglePolygon.horizontal_line_inside?(h, 3, 7, 5)
    end

    test "On the line", %{h: h} do
      assert RightAnglePolygon.horizontal_line_inside?(h, 3, 7, 2)
      assert RightAnglePolygon.horizontal_line_inside?(h, 3, 7, -2)
    end

    test "On and off the line inside", %{h: h} do
      assert RightAnglePolygon.horizontal_line_inside?(h, 0, 10, -2)
      assert RightAnglePolygon.horizontal_line_inside?(h, 0, 10, 2)
    end

    test "On and off outside", %{h: h} do
      refute RightAnglePolygon.horizontal_line_inside?(h, 0, 10, -5)
      refute RightAnglePolygon.horizontal_line_inside?(h, 0, 10, 5)
    end
  end
end
