defmodule BitstylesPhoenix do
  @moduledoc """
  Documentation for BitstylesPhoenix.

  ## Setup & Getting started

  Check out the main [README](README.md).

  ## Usage

  Use by either `use BitstylesPhoenix` or importing the components and helpers individually.

  ```elixir
    use BitstylesPhoenix

    # or

    import BitstylesPhoenix.Helper.Button
  ```

  Then use the components and helpers in your `*.heex` templates.

  ```elixir
  ui_button("Save", type: "submit")
  # => <button class="a-button" type="submit">Save</button>
  ```

  Checkout the components and helpers for examples and showcases.
  """

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Component.Badge
      import BitstylesPhoenix.Component.Flash
      import BitstylesPhoenix.Component.Icon
      import BitstylesPhoenix.Component.Error
      import BitstylesPhoenix.Component.Form

      import BitstylesPhoenix.Helper.Button
      import BitstylesPhoenix.Helper.Classnames
      import BitstylesPhoenix.Helper.UseSVG
    end
  end
end
