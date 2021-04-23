defmodule BitstylesPhoenix.ComponentTest do
  use ExUnit.Case
  import Phoenix.HTML, only: [safe_to_string: 1]
  use BitstylesPhoenix.Components

  doctest BitstylesPhoenix.Badge
  doctest BitstylesPhoenix.Button
  doctest BitstylesPhoenix.Error
  doctest BitstylesPhoenix.Flash
  doctest BitstylesPhoenix.Icon
  doctest BitstylesPhoenix.Time
end
