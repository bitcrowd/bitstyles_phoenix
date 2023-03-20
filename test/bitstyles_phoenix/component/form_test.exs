defmodule BitstylesPhoenix.Component.FormTest do
  use BitstylesPhoenix.ComponentCase, async: true
  import Phoenix.Component

  @form Phoenix.Component.to_form(%{}, as: :user)
  @form_with_errors Phoenix.Component.to_form(%{},
                      as: :user,
                      errors: [
                        name: {"is too short", []},
                        email: {"is invalid", []},
                        email: "must end with @bitcrowd.net"
                      ]
                    )

  doctest BitstylesPhoenix.Component.Form
end
