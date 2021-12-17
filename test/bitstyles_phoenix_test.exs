defmodule BitstylesPhoenixTest do
  use ExUnit.Case, async: true
  use BitstylesPhoenix

  alias Phoenix.LiveView.Helpers, as: LiveHelpers

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      ui_button("foo", [])

      LiveHelpers.component(&ui_badge/1, inner_content: "foo")
    end
  end
end
