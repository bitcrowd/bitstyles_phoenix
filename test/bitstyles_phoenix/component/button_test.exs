defmodule BitstylesPhoenix.Component.ButtonTest do
  use BitstylesPhoenix.ComponentCase, async: true

  doctest BitstylesPhoenix.Component.Button

  describe "ui_button/1" do
    test "deprecate :to" do
      warning =
        ExUnit.CaptureIO.capture_io(:stderr, fn ->
          assigns = %{}

          result =
            render(~H"""
            <.ui_button to="/foo">
              Show
            </.ui_button>
            """)

          assert result ==
                   """
                   <a href="/foo" class="a-button" to="/foo">
                     Show
                   </a>
                   """
        end)

      assert String.contains?(warning, "deprecated")
    end

    test "deprecate :variant" do
      warning =
        ExUnit.CaptureIO.capture_io(:stderr, fn ->
          assigns = %{}

          result =
            render(~H"""
            <.ui_button variant="ui">
              Show
            </.ui_button>
            """)

          assert result ==
                   """
                   <button type="button" class="a-button a-button--secondary">
                     Show
                   </button>
                   """
        end)

      assert String.contains?(warning, "deprecated")
    end
  end
end
