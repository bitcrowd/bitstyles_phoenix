defmodule BitstylesPhoenix.Component.ErrorTest do
  use BitstylesPhoenix.ComponentCase, async: true

  @form_with_errors Phoenix.Component.to_form(%{},
                      as: :user,
                      errors: [
                        single: {"is too short", []},
                        multiple: {"is simply bad", []},
                        multiple: "not fun"
                      ]
                    )

  doctest BitstylesPhoenix.Component.Error
end
