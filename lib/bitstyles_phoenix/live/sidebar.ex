defmodule BitstylesPhoenix.Live.Sidebar do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Sidebar, as: RawSidebar
  alias Phoenix.LiveView.JS
  import BitstylesPhoenix.Component.Button
  import Phoenix.LiveView.Utils, only: [random_id: 0]

  @moduledoc """
  Components for rendering a sidebar layout powered by LiveView commands.
  """

  @doc """
  Renders a sidebar layout with LiveView commands.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Sidebar.ui_sidebar_layout/1`.

  The `small_sidebar` and `main`/`inner` blocks will additionally provide a block argument
  with the sidebar context for `ui_js_sidebar_open/1` and `ui_js_sidebar_close/1`.

  For examles see `BitstylesPhoenix.Component.Sidebar.ui_sidebar_layout/1`.
  """

  def ui_js_sidebar_layout(assigns) do
    extra = assigns_to_attributes(assigns, [:small_sidebar])

    {_, small_extra} = assigns_from_single_slot(assigns, :small_sidebar, optional: true)
    {_, main_extra} = assigns_from_single_slot(assigns, :main, optional: true)

    small_extra = Keyword.put_new_lazy(small_extra, :id, &random_id/0)

    assigns = assign(assigns, small_extra: small_extra, extra: extra, main_extra: main_extra)

    ~H"""
    <RawSidebar.ui_sidebar_layout {@extra} >
      <:small_sidebar
        style="display: none"
        {@small_extra}>
        <%= render_slot(assigns[:small_sidebar], @small_extra[:id]) %>
      </:small_sidebar>
      <:main {@main_extra}>
        <%= render_slot(assigns[:main] || @inner_block, @small_extra[:id]) %>
      </:main>
    </RawSidebar.ui_sidebar_layout>
    """
  end

  @doc """
  A sidebar close icon to be rendered on the open sidebar for closing the sidebar.

  ## Attributes
  - `label` - A screen reader label for the icon. Defaults to `"Close"`.
  - `sidebar` - The reference to the sidebar it controls. This will be the sidebar `id`.
    The `ui_js_sidebar_layout/1` can provide this as a block argument in the small sidebar block.
  """
  def ui_js_sidebar_close(assigns) do
    id = assigns.sidebar

    options =
      assigns
      |> assigns_to_attributes([:sidebar, :icon])
      |> Keyword.merge(
        "phx-click":
          JS.hide(to: "##{id}", transition: {"is-transitioning", "is-on-screen", "is-off-screen"}),
        "aria-controls": id
      )
      |> Keyword.put_new(:reversed, true)

    assigns = assign(assigns, icon: assigns[:icon] || "cross", options: options)

    ~H"""
    <.ui_icon_button icon={@icon} label={assigns[:label] || "Close"} {@options} />
    """
  end

  @doc """
  A sidebar open icon to be rendered on the main content for opening the sidebar.

  ## Attributes
  - `label` - A screen reader label for the icon. Defaults to `"Open sidebar"`.
  - `sidebar` - The reference to the sidebar it controls. This will be the sidebar `id`.
    The `ui_js_sidebar_layout/1` can provide this as a block argument in the main or inner block.
  """
  def ui_js_sidebar_open(assigns) do
    id = assigns.sidebar

    options =
      assigns
      |> assigns_to_attributes([:sidebar, :icon])
      |> Keyword.merge(
        "phx-click":
          JS.show(to: "##{id}", transition: {"is-transitioning", "is-off-screen", "is-on-screen"}),
        "aria-controls": id
      )
      |> Keyword.put(:class, classnames(["u-hidden@l", assigns[:class]]))

    assigns = assign(assigns, icon: assigns[:icon] || "hamburger", options: options)

    ~H"""
    <.ui_icon_button icon={@icon} label={assigns[:label] || "Open sidebar"} {@options} />
    """
  end
end
