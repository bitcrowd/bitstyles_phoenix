defmodule BitstylesPhoenixWebDemo.BitstylesPhoenixTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  feature "renders errors from gettext", %{session: session} do
    session
    |> visit("/")
    |> find(Query.css(".e2e-form", count: 1))
    |> assert_has(Query.css(".u-fg--warning", text: "can't be blank"))

    session
    |> find(Query.css(".e2e-form-de", count: 1))
    |> assert_has(Query.css(".u-fg--warning", text: "muss ausgefüllt werden"))
  end
end
