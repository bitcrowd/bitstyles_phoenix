defmodule BitstylesPhoenix do
  use BitstylesPhoenix.Components
  use BitstylesPhoenix.Showcase

  @moduledoc """
  Documentation for BitstylesPhoenix.

  ## Setup & Getting started

  Check out the main [README](README.md).
  """

  showcase_section("Buttons", "Components.Button.ui_button/2")

  showcase("Default", """
    ui_button("Button", type: "submit")
  """)

  showcase("UI", """
    ui_button("Button", variant: :ui)
  """)

  showcase("Danger", """
    ui_button("Button", variant: :danger)
  """)

  showcase("UI Danger", """
    ui_button("Button", variant: [:ui, :danger])
  """)

  showcase_section("Errors", "Components.Error.ui_error_tag/1")

  showcase("Inline errors", """
    ui_error_tag("Some error")
  """)

  showcase_section("Icons", "Components.Icon.ui_icon/2")

  showcase("Icon", """
    ui_icon("trashcan")
  """)

  showcase("Icon size: l", """
    ui_icon("trashcan", size: "l")
  """)

  showcase("Icon size: l, width: 40", """
    ui_icon("trashcan", size: "l", width: "40", height: "40")
  """)
end
