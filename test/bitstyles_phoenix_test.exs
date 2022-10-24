defmodule BitstylesPhoenixTest do
  use ExUnit.Case, async: true
  use BitstylesPhoenix

  alias Phoenix.LiveView.HTMLEngine

  describe "short-cut imports" do
    test "can use the ui_* helpers" do
      classnames(["foo", "bar"])

      HTMLEngine.component(
        &ui_badge/1,
        [inner_content: "foo"],
        {__ENV__.module, __ENV__.function, __ENV__.file, __ENV__.line}
      )
    end
  end
end
