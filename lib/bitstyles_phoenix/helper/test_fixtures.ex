defmodule BitstylesPhoenix.Helper.TestFixtures do
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
