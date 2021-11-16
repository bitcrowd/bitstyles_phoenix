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

  feature "allows icon config and can still render inline", %{session: session} do
    session
    |> visit("/")
    |> find(Query.css(".e2e-external-svg-icon use", count: 1), fn element ->
      assert {width, height} = Element.size(element)
      assert width > 0
      assert height > 0
    end)
    |> find(Query.css(".e2e-inline-svg-icon use", count: 1), fn element ->
      assert {width, height} = Element.size(element)
      assert width > 0
      assert height > 0
    end)
  end
end
