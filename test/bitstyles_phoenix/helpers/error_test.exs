defmodule BitstylesPhoenix.ErrorTest do
  use BitstylesPhoenix.ComponentCase

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
