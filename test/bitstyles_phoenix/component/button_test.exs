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
  end

  describe "ui_icon_button/1 with the current bistyles version" do
    test "renders a default button wrapping an SVG icon" do
      assigns = %{}

      result =
        render(~H"""
        <.ui_icon_button icon="plus" label="Add" href="#"/>
        """)

      assert result ==
               """
               <a href="#" class="a-button" title="Add">
                 <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
                   <use xlink:href="#icon-plus">
                   </use>
                 </svg>
                 <span class="u-sr-only">
                   Add
                 </span>
               </a>
               """
    end
  end

  describe "ui_icon_button/1 with bitstyles version < 5.0.0" do
    test "renders a button with the variant `icon` wrapping an SVG icon" do
      assigns = %{}

      result =
        render(~H"""
        <.ui_icon_button icon="plus" label="Add" href="#" version="4.3.1"/>
        """)

      assert result ==
               """
               <a href="#" class="a-button a-button--icon" title="Add">
                 <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
                   <use xlink:href="#icon-plus">
                   </use>
                 </svg>
                 <span class="u-sr-only">
                   Add
                 </span>
               </a>
               """
    end

    test "accepts a reversed attribute to render a reversed button" do
      assigns = %{}

      result =
        render(~H"""
        <.ui_icon_button icon="plus" label="Add" href="#" reversed version="4.3.1"/>
        """)

      assert result ==
               """
               <a href="#" class="a-button a-button--icon a-button--icon-reversed" title="Add">
                 <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
                   <use xlink:href="#icon-plus">
                   </use>
                 </svg>
                 <span class="u-sr-only">
                   Add
                 </span>
               </a>
               """
    end
  end
end
