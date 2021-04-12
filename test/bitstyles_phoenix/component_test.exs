defmodule BitstylesPhoenix.ComponentTest do
  use ExUnit.Case
  import Phoenix.HTML, only: [safe_to_string: 1]
  use BitstylesPhoenix.Components

  doctest BitstylesPhoenix.Components.Button
  doctest BitstylesPhoenix.Components.Error
  doctest BitstylesPhoenix.Components.Flash
  doctest BitstylesPhoenix.Components.Icon
  doctest BitstylesPhoenix.Components.Time

end
