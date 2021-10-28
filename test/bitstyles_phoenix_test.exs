defmodule BitstylesPhoenixTest do
  use ExUnit.Case
  use BitstylesPhoenix

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      ui_error_tag("foo")

      Phoenix.LiveView.Helpers.component(&ui_badge/1, inner_content: "foo")
    end
  end
end
