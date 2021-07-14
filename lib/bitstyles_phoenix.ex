defmodule BitstylesPhoenix do
  @components [
    BitstylesPhoenix.Badge,
    BitstylesPhoenix.Button,
    BitstylesPhoenix.Error,
    BitstylesPhoenix.Flash,
    BitstylesPhoenix.Form,
    BitstylesPhoenix.Icon,
    BitstylesPhoenix.Time,
    BitstylesPhoenix.UseSVG
  ]

  @moduledoc """
  Documentation for BitstylesPhoenix.

  ## Setup & Getting started

  Check out the main [README](README.md).

  ## Usage

  Use by either `BitstylesPhoenix.Components` or importing the components individually.

  ```elixir
    use BitstylesPhoenix.Components

    # or

    import BitstylesPhoenix.Button
  ```

  Then call the `ui_*` helpers from the components usable in your views.

  ```elixir
  ui_button("Save", type: "submit")
  # => <button class="a-button" type="submit">Save</button>
  ```

  Checkout the components for examples and showcases.

  #{
    @components
    |> Enum.map(&"- `#{Module.split(&1) |> Enum.join(".")}`")
    |> Enum.join("\n")
  }
  """

  @doc false
  def components(), do: @components
end
