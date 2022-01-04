defmodule BitstylesPhoenix.Live.Dropdown do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Dropdown, as: RawDropdown
  alias Phoenix.LiveView.JS

  import Phoenix.LiveView.Utils, only: [random_id: 0]

  @moduledoc """
  Components for rendering a drowdowns powered by LiveView commands.
  """

  @doc """
  Renders a dropdown component with a button, a menu and options with JS commands.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Dropdown.ui_dropdown`.
  """

  def ui_js_dropdown(assigns) do
    extra = assigns_to_attributes(assigns, [:menu, :button])

    {_, button_extra} = assigns_from_single_slot(assigns, :button)

    {_, menu_extra} = assigns_from_single_slot(assigns, :menu)

    menu_extra = Keyword.put_new_lazy(menu_extra, :id, &random_id/0)

    assigns =
      assign(assigns,
        extra: extra,
        button_extra: button_extra,
        menu_extra: menu_extra,
        menu_id: menu_extra[:id]
      )

    ~H"""
    <RawDropdown.ui_dropdown {@extra}>
      <:button
        phx-click={JS.toggle(to: "##{@menu_id}",
                             in: {"is-transitioning", "is-off-screen", "is-on-screen"},
                             out: {"is-transitioning", "is-on-screen", "is-off-screen"})}
        aria-controls={@menu_id}
        {@button_extra}
        >
        <%= render_slot(@button) %>
      </:button>
      <:menu
        style="display: none"
        phx-click-away={JS.hide(to: "##{@menu_id}",transition: {"is-transitioning", "is-on-screen", "is-off-screen"})}
        {@menu_extra}
        >
        <%= render_slot(@menu) %>
      </:menu>
    </RawDropdown.ui_dropdown>
    """
  end
end
