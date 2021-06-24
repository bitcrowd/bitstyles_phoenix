defmodule BitstylesPhoenix.ErrorTest do
  use ExUnit.Case

  import BitstylesPhoenix.Error
  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form

  @error_form form_for(:user, "/",
                errors: [
                  single: ["is too short"],
                  multiple: ["is simply bad"],
                  multiple: "not fun"
                ]
              )
  doctest BitstylesPhoenix.Error
end
