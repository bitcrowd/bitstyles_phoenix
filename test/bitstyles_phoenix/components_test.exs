defmodule BitstylesPhoenix.ComponentsTest do
  use ExUnit.Case

  use BitstylesPhoenix.Components

  import Phoenix.HTML, only: [safe_to_string: 1]

  doctest BitstylesPhoenix.Button
  doctest BitstylesPhoenix.Icon
  doctest BitstylesPhoenix.Time

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      ui_error_tag("foo")

      Phoenix.LiveView.Helpers.component(&ui_badge/1, [])
    end
  end
end
