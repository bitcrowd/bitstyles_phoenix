defmodule BitstylesPhoenixTest do
  use ExUnit.Case, async: true
  use BitstylesPhoenix
  import Phoenix.Component

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      classnames(["foo", "bar"])

      assigns = %{inner_content: "foo"}
      ~H"<.ui_badge />"
    end
  end
end
