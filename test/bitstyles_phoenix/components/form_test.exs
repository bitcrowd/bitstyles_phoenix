defmodule BitstylesPhoenix.FormTest do
  use ExUnit.Case

  import BitstylesPhoenix.Form

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form

  @user_form form_for(:user, "/")
  @file_form form_for(:user, "/", multipart: true)
  @error_form form_for(:user, "/",
                errors: [
                  name: ["is too short"],
                  email: ["is invalid"],
                  email: "must end with @bitcrowd.net"
                ]
              )

  doctest BitstylesPhoenix.Form
end
