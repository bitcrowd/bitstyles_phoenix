defmodule DoctestHelper do
  def doctest_ui_component(component) do
    component
    |> Phoenix.HTML.safe_to_string()
  end
end
