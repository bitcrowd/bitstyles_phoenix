defmodule BitstylesPhoenix.Component.FormTest do
  use BitstylesPhoenix.ComponentCase, async: true

  import Phoenix.HTML.Form

  @user_form form_for(:user, "/")
  @file_form form_for(:user, "/", multipart: true)
  @error_form form_for(:user, "/",
                errors: [
                  name: {"is too short", []},
                  email: {"is invalid", []},
                  email: "must end with @bitcrowd.net"
                ]
              )

  doctest BitstylesPhoenix.Component.Form
end
