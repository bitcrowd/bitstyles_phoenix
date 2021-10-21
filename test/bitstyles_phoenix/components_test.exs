defmodule BitstylesPhoenix.ComponentsTest do
  use ExUnit.Case

  use BitstylesPhoenix.Components

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.LiveView.Helpers

  defp h2s(template) do
    template
    |> Phoenix.HTML.Safe.to_iodata()
    |> IO.iodata_to_binary()
  end

  doctest BitstylesPhoenix.Badge
  doctest BitstylesPhoenix.Button
  doctest BitstylesPhoenix.Flash
  doctest BitstylesPhoenix.Icon
  doctest BitstylesPhoenix.Time

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      ui_error_tag("foo")
      ui_badge("foo")
    end
  end
end
