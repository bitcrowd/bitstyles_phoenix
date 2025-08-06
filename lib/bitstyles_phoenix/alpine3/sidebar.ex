defmodule BitstylesPhoenix.Alpine3.Sidebar do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Sidebar, as: RawSidebar
  import BitstylesPhoenix.Component.Button
  import Phoenix.LiveView.Utils, only: [random_id: 0]

  @moduledoc """
  Components for rendering a sidebar layout powered by Alpine 3.
  """

  story(
    "Full example",
    """
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_js_sidebar_layout>
        ...>   <:large_sidebar>
        ...>     <a href="#" class="u-padding-l">
        ...>       <img src="assets/logo.svg" aria-hidden="true" width="100"/>
        ...>       <span class="u-sr-only">
        ...>         bitcrowd
        ...>       </span>
        ...>     </a>
        ...>   </:large_sidebar>
        ...>   <:small_sidebar :let={s} id="sidebar-small">
        ...>     <div class="u-flex">
        ...>       <a href="#" class="u-flex-grow-1 u-padding-l">
        ...>         <img src="assets/logo.svg" aria-hidden="true" width="100" />
        ...>         <span class="u-sr-only">bitcrowd</span>
        ...>       </a>
        ...>       <div>
        ...>         <.ui_js_sidebar_close sidebar={s}/>
        ...>       </div>
        ...>     </div>
        ...>   </:small_sidebar>
        ...>   <:sidebar_content>
        ...>     <.ui_sidebar_nav>
        ...>       <.ui_sidebar_nav_item><.ui_button href="#" class="u-flex-grow-1" color="transparent">Menu item #1</.ui_button></.ui_sidebar_nav_item>
        ...>       <.ui_sidebar_nav_item><.ui_button href="#" class="u-flex-grow-1" color="transparent">Menu item #2</.ui_button></.ui_sidebar_nav_item>
        ...>     </.ui_sidebar_nav>
        ...>   </:sidebar_content>
        ...>   <:main :let={s} class="u-margin-s2-top">
        ...>     <.ui_content class="flex">
        ...>       <.ui_js_sidebar_open sidebar={s} class="u-margin-s2-right"/>
        ...>       Main Content
        ...>     </.ui_content>
        ...>   </:main>
        ...> </.ui_js_sidebar_layout>
        ...> """
    """,
    """
        \"""
        <div class="u-flex u-height-100vh" x-data="{ sidebarOpen: false }">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg-grayscale-dark-2 u-fg-grayscale-light-2">
                <a href="#" class="u-padding-l">
                  <img src="assets/logo.svg" aria-hidden="true" width="100"/>
                  <span class="u-sr-only">
                    bitcrowd
                  </span>
                </a>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow-y-auto u-list-none u-flex u-flex-col u-items-stretch u-padding-s4-right u-padding-s4-left">
                  <li class="u-margin-s4-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-s4-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #2
                    </a>
                  </li>
                </ul>
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg-grayscale-dark-2 u-fg-grayscale-light-2" @click.away="sidebarOpen = false" id="sidebar-small" x-cloak="x-cloak" x-show="sidebarOpen" x-transition:enter="is-transitioning" x-transition:enter-end="is-on-screen" x-transition:enter-start="is-off-screen" x-transition:leave="is-transitioning" x-transition:leave-end="is-off-screen" x-transition:leave-start="is-on-screen">
                <div class="u-flex">
                  <a href="#" class="u-flex-grow-1 u-padding-l">
                    <img src="assets/logo.svg" aria-hidden="true" width="100"/>
                    <span class="u-sr-only">
                      bitcrowd
                    </span>
                  </a>
                  <div>
                    <button type="button" :aria-expanded="sidebarOpen" @click="sidebarOpen = false" aria-controls="sidebar-small" class="a-button a-button--square" data-theme="dark" title="Close">
                      <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
                        <use xlink:href="#icon-cross">
                        </use>
                      </svg>
                      <span class="u-sr-only">
                        Close
                      </span>
                    </button>
                  </div>
                </div>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow-y-auto u-list-none u-flex u-flex-col u-items-stretch u-padding-s4-right u-padding-s4-left">
                  <li class="u-margin-s4-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-s4-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #2
                    </a>
                  </li>
                </ul>
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow-y-auto u-margin-s2-top">
            <div class="a-content flex">
              <button type="button" :aria-expanded="sidebarOpen" @click="sidebarOpen = true" aria-controls="sidebar-small" class="a-button a-button--square u-hidden@l u-margin-s2-right" title="Open sidebar">
                <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
                  <use xlink:href="#icon-hamburger">
                  </use>
                </svg>
                <span class="u-sr-only">
                  Open sidebar
                </span>
              </button>
              Main Content
            </div>
          </main>
        </div>
        \"""
    """,
    width: "100%",
    height: "300px",
    transparent: false,
    module: true,
    extra_html: """
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.5.1/cdn.min.js" defer></script>
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-cross" viewBox="0 0 100 100">
        <path d="M84.12,76.7,57.43,50,84.12,23.3a5.25,5.25,0,0,0-7.42-7.42L50,42.57,23.3,15.88a5.25,5.25,0,0,0-7.42,7.42L42.57,50,15.88,76.7a5.25,5.25,0,1,0,7.42,7.42L50,57.43,76.7,84.12a5.25,5.25,0,1,0,7.42-7.42Z"/>
      </symbol>
      <symbol id="icon-hamburger" viewBox="0 0 100 100">
        <path d="M6,25.57a4.58,4.58,0,0,1,3.23-7.82H88.9a4.58,4.58,0,0,1,0,9.15H9.25A4.54,4.54,0,0,1,6,25.57ZM88.9,45.43H9A4.59,4.59,0,0,0,4.68,50a4.56,4.56,0,0,0,4.57,4.57H88.9A4.58,4.58,0,0,0,93.48,50h0A4.59,4.59,0,0,0,88.9,45.43Zm0,27.67H9.25a4.58,4.58,0,0,0,0,9.15H88.9a4.58,4.58,0,1,0,0-9.15Z"/>
      </symbol>
    </svg>
    """
  )

  @doc """
  Renders a sidebar layout with Alpine3.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Sidebar.ui_sidebar_layout/1`.

  ## Attributes
  - `x_name` - The name of the boolean x-data property for alpine to store the menu state.
    Defaults to `"sidebarOpen"`.

  The `small_sidebar` and `main`/`inner` blocks will additionally provide a block argument
  with the sidebar context for `ui_js_sidebar_open/1` and `ui_js_sidebar_close/1`.

  ## Prevent page-flickering

  The sidebar small layout sets the `x-cloak` property on the menu to avoid flickering on initial page load.
  To make this work, you need to add the following snippet to your stylesheets:

     [x-cloak] { display: none !important; }

  See https://alpinejs.dev/directives/cloak for more information on `x-cloak`.
  """

  def ui_js_sidebar_layout(assigns) do
    {_, small_extra} = assigns_from_single_slot(assigns, :small_sidebar, optional: true)
    {_, main_extra} = assigns_from_single_slot(assigns, :main, optional: true)

    extra = assigns_to_attributes(assigns, [:x_data, :small_sidebar])
    small_extra = Keyword.put_new_lazy(small_extra, :id, &random_id/0)

    assigns =
      assign(assigns,
        small_extra: small_extra,
        extra: extra,
        main_extra: main_extra,
        x_data: Map.get(assigns, :x_data, "sidebarOpen")
      )

    ~H"""
    <RawSidebar.ui_sidebar_layout x-data={"{ #{@x_data}: false }"} {@extra} >
      <:small_sidebar
        x-cloak
        x-show="sidebarOpen"
        @click.away="sidebarOpen = false"
        x-transition:enter="is-transitioning"
        x-transition:enter-start="is-off-screen"
        x-transition:enter-end="is-on-screen"
        x-transition:leave="is-transitioning"
        x-transition:leave-start="is-on-screen"
        x-transition:leave-end="is-off-screen"
        {@small_extra}>
        <%= assigns[:small_sidebar] && render_slot(assigns[:small_sidebar], {@x_data, @small_extra[:id]}) %>
      </:small_sidebar>
      <:main {@main_extra}>
        <%= render_slot(assigns[:main] || @inner_block, {@x_data, @small_extra[:id]}) %>
      </:main>
    </RawSidebar.ui_sidebar_layout>
    """
  end

  @doc """
  A sidebar close icon to be rendered on the open sidebar for closing the sidebar.
  For examles see `ui_js_sidebar_layout/1`.

  ## Attributes
  - `label` - A screen reader label for the icon. Defaults to `"Close"`.
  - `sidebar` - The reference to the sidebar it controls. This is a tuple with the sidebar's `x_name` and the sidebars `id`.
    The `ui_js_sidebar_layout/1` can provide this as a block argument in the small sidebar block.
  """
  def ui_js_sidebar_close(assigns) do
    {x_data, id} = assigns.sidebar

    options =
      assigns
      |> assigns_to_attributes([:sidebar, :icon])
      |> Keyword.merge(
        "@click": "#{x_data} = false",
        "aria-controls": id,
        ":aria-expanded": x_data
      )
      |> Keyword.put_new(:reversed, true)

    assigns = assign(assigns, icon: assigns[:icon] || "cross", options: options)

    ~H"""
    <.ui_icon_button icon={@icon} label={assigns[:label] || "Close"} {@options} />
    """
  end

  @doc """
  A sidebar open icon to be rendered on the main content for opening the sidebar.
  For examles see `ui_js_sidebar_layout/1`.

  ## Attributes
  - `label` - A screen reader label for the icon. Defaults to `"Open sidebar"`.
  - `sidebar` - The reference to the sidebar it controls. This is a tuple with the sidebar's `x_name` and the sidebars `id`.
    The `ui_js_sidebar_layout/1` can provide this as a block argument in the main or inner block.
  """
  def ui_js_sidebar_open(assigns) do
    {x_data, id} = assigns.sidebar

    options =
      assigns
      |> assigns_to_attributes([:sidebar, :icon])
      |> Keyword.merge(
        "@click": "#{x_data} = true",
        "aria-controls": id,
        ":aria-expanded": x_data
      )
      |> Keyword.put(:class, classnames(["u-hidden@l", assigns[:class]]))

    assigns = assign(assigns, icon: assigns[:icon] || "hamburger", options: options)

    ~H"""
    <.ui_icon_button icon={@icon} label={assigns[:label] || "Open sidebar"} {@options} />
    """
  end
end
