defmodule BitstylesPhoenix.Live.Dropdown do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Dropdown, as: RawDropdown
  alias Phoenix.LiveView.JS

  import Phoenix.LiveView.Utils, only: [random_id: 0]

  @doc """
  Renders a dropdown component with a button, a menu and options with JS commands.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Dropdown.ui_dropdown`.
  """

  def ui_js_dropdown(assigns) do
    extra = assigns_to_attributes(assigns, [:menu, :button])

    button_assigns = assigns_from_single_slot(assigns, :button, with: :button_extra)

    menu_assigns =
      assigns_from_single_slot(assigns, :menu,
        with: fn slot, extra -> get_menu_assigns(slot.id, extra) end,
        exclude: [:id],
        default: &get_menu_assigns/0
      )

    assigns =
      assigns
      |> assign(extra: extra)
      |> assign(button_assigns)
      |> assign(menu_assigns)

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
        id={@menu_id}
        style="display: none"
        phx-click-away={JS.hide(to: "##{@menu_id}",transition: {"is-transitioning", "is-on-screen", "is-off-screen"})}
        {@menu_extra}
        />
    </RawDropdown.ui_dropdown>
    """
  end

  defp get_menu_assigns(), do: get_menu_assigns(random_id(), %{})

  defp get_menu_assigns(nil, extra), do: get_menu_assigns(random_id(), extra)

  defp get_menu_assigns(id, extra), do: [menu_id: id, menu_extra: extra]
end
