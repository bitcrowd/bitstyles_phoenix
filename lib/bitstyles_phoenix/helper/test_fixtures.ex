defmodule BitstylesPhoenix.Helper.TestFixtures do
  @moduledoc "Static values helpful in writing doctests."

  # This module is in `/lib` and not in `/test` so that it can be used in the dev env
  # in the mix task Mix.Tasks.BitstylesPhoenix.GenerateVersionsShowcase

  def form() do
    Phoenix.Component.to_form(%{}, as: :user)
  end

  def form_with_errors do
    Phoenix.Component.to_form(%{},
      as: :user,
      errors: [
        name: {"is too short", []},
        email: {"is invalid", []},
        email: "must end with @bitcrowd.net"
      ]
    )
  end
end
