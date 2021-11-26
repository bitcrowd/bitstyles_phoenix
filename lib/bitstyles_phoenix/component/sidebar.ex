defmodule BitstylesPhoenix.Component.Sidebar do
  use BitstylesPhoenix.Component

  @moduledoc """
  The sidebar component without any JS.
  """
  story(
    "Sidebar with items",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_sidebar_layout>
        ...>   <:large_sidebar>Large header</:large_sidebar>
        ...>   <:small_sidebar>Small header</:small_sidebar>
        ...>   <:sidebar_content>
        ...>     <.ui_sidebar_section border="bottom">
        ...>       Menu
        ...>     </.ui_sidebar_section>
        ...>     <.ui_sidebar_nav>
        ...>       <:item><%= ui_button "Menu item #1", to: "#", class: "u-flex-grow-1", variant: "nav" %></:item>
        ...>       <:item><%= ui_button "Menu item #2", to: "#", class: "u-flex-grow-1", variant: "nav" %></:item>
        ...>     </.ui_sidebar_nav>
        ...>     <.ui_sidebar_section border="top">
        ...>       <.ui_dropdown variant={["top", "full-width"]}>
        ...>         <:button variant="nav-large">
        ...>           <div class="a-button__icon a-avatar">
        ...>             <img src="https://placekitten.com/100/150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar" />
        ...>           </div>
        ...>           <span class="a-button__label">Jane Dobermann</span>
        ...>         </:button>
        ...>         <:option><%= ui_button "Logout", to: "#", variant: "menu" %></:option>
        ...>       </.ui_dropdown>
        ...>     </.ui_sidebar_section>
        ...>   </:sidebar_content>
        ...>   Main Content
        ...> </.ui_sidebar_layout>
        ...> """
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg--gray-80 u-fg--gray-30">
                Large header
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-bottom u-margin-xs-bottom">
                  Menu
                </div>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow--y a-list-reset u-flex u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left">
                  <li class="u-margin-xs-bottom u-flex">
                    <a class="a-button a-button--nav u-flex-grow-1" href="#">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-xs-bottom u-flex">
                    <a class="a-button a-button--nav u-flex-grow-1" href="#">
                      Menu item #2
                    </a>
                  </li>
                </ul>
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-top u-margin-xs-top">
                  <div class="u-relative">
                    <button class="a-button a-button--nav-large" type="button">
                      <div class="a-button__icon a-avatar">
                        <img src="https://placekitten.com/100/150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar"/>
                      </div>
                      <span class="a-button__label">
                        Jane Dobermann
                      </span>
                    </button>
                    <ul class="a-dropdown u-overflow--y a-list-reset a-dropdown--top a-dropdown--full-width u-margin-s-bottom">
                      <li>
                        <a class="a-button a-button--menu" href="#">
                          Logout
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg--gray-80 u-fg--gray-30">
                Small header
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-bottom u-margin-xs-bottom">
                  Menu
                </div>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow--y a-list-reset u-flex u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left">
                  <li class="u-margin-xs-bottom u-flex">
                    <a class="a-button a-button--nav u-flex-grow-1" href="#">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-xs-bottom u-flex">
                    <a class="a-button a-button--nav u-flex-grow-1" href="#">
                      Menu item #2
                    </a>
                  </li>
                </ul>
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-top u-margin-xs-top">
                  <div class="u-relative">
                    <button class="a-button a-button--nav-large" type="button">
                      <div class="a-button__icon a-avatar">
                        <img src="https://placekitten.com/100/150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar"/>
                      </div>
                      <span class="a-button__label">
                        Jane Dobermann
                      </span>
                    </button>
                    <ul class="a-dropdown u-overflow--y a-list-reset a-dropdown--top a-dropdown--full-width u-margin-s-bottom">
                      <li>
                        <a class="a-button a-button--menu" href="#">
                          Logout
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow--y">
            Main Content
          </main>
        </div>
        """
    ''',
    width: "100%",
    height: "500px",
    transparent: false,
    module: true
  )

  @doc """
  Renders a sidebar component.

  *In order for the sidebar to be collapsible in small screens, you need to provide extra JS attributes.*

  ## Attributes

  - `class` - Extra classes to pass to the outer `div`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the outer `div`

  """

  story(
    "Bare sidebar",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_sidebar_layout>
        ...>   <:large_sidebar>Large header</:large_sidebar>
        ...>   <:small_sidebar>Small header</:small_sidebar>
        ...>   <:sidebar_content><div>Sidebar</div></:sidebar_content>
        ...>   <:main>Main Content</:main>
        ...> </.ui_sidebar_layout>
        ...> """
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg--gray-80 u-fg--gray-30">
                Large header
                <div>
                  Sidebar
                </div>
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg--gray-80 u-fg--gray-30">
                Small header
                <div>
                  Sidebar
                </div>
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow--y">
            Main Content
          </main>
        </div>
        """
    ''',
    width: "100%",
    height: "300px",
    transparent: false
  )

  story(
    "All slots are optional",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_sidebar_layout>
        ...>   Main Content
        ...> </.ui_sidebar_layout>
        ...> """
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg--gray-80 u-fg--gray-30">
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg--gray-80 u-fg--gray-30">
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow--y">
            Main Content
          </main>
        </div>
        """
    ''',
    width: "100%",
    height: "300px",
    transparent: false
  )

  @default_bg "gray-80"
  @default_fg "gray-30"
  @large_classes "u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col"
  @small_classes "o-sidebar--small u-flex u-flex-col u-hidden@l"

  def ui_sidebar_layout(assigns) do
    {sidebar, sidebar_extra} =
      assigns_from_single_slot(assigns, :sidebar_content,
        exclude: [:class, :bg, :fg],
        optional: true
      )

    {large_sidebar, large_extra} =
      assigns_from_single_slot(assigns, :large_sidebar,
        exclude: [:class, :bg, :fg],
        optional: true
      )

    {small_sidebar, small_extra} =
      assigns_from_single_slot(assigns, :small_sidebar,
        exclude: [:class, :bg, :fg],
        optional: true
      )

    {_, main_extra} = assigns_from_single_slot(assigns, :main, optional: true)

    extra =
      assigns_to_attributes(assigns, [
        :class,
        :sidebar_content,
        :large_sidebar,
        :small_sidebar,
        :main
      ])

    assigns =
      assigns
      |> assign(
        class: classnames(["u-flex u-height-100vh", assigns[:class]]),
        extra: extra,
        sidebar_extra: sidebar_extra,
        large_extra: large_extra,
        small_extra: small_extra,
        main_extra: main_extra,
        large_class: sidebar_classnames(large_sidebar, sidebar, @large_classes),
        small_class: sidebar_classnames(small_sidebar, sidebar, @small_classes)
      )

    ~H"""
      <div class={@class} {@extra}>
        <header role="banner" class="u-flex">
          <nav class="u-flex">
            <div class={@large_class} {@sidebar_extra} {@large_extra}>
              <%= assigns[:large_sidebar] && render_slot(@large_sidebar) %>
              <%= assigns[:sidebar_content] &&render_slot(@sidebar_content) %>
            </div>
            <div class={@small_class} {@sidebar_extra} {@small_extra}>
              <%= assigns[:small_sidebar] && render_slot(@small_sidebar)%>
              <%= assigns[:sidebar_content] && render_slot(@sidebar_content) %>
            </div>
          </nav>
        </header>
        <main class="u-flex-grow-1 u-overflow--y" {@main_extra}>
          <%= render_slot(assigns[:main] || @inner_block) %>
        </main>
      </div>
    """
  end

  defp sidebar_classnames(sidebar_layout, sidebar, default_classes) do
    sidebar_layout = sidebar_layout || %{}
    bg = Map.get(sidebar_layout, :bg, @default_bg)
    fg = Map.get(sidebar_layout, :fg, @default_fg)

    classnames([
      default_classes,
      {"u-bg--#{bg}", !!bg},
      {"u-fg--#{fg}", !!fg},
      sidebar && sidebar[:class],
      sidebar_layout[:class]
    ])
  end

  @sidebar_nav_classes "u-flex-grow-1 u-flex-shrink-1 u-overflow--y a-list-reset u-flex u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left"
  def ui_sidebar_nav(assigns) do
    extra = assigns_to_attributes(assigns, [:item, :class])
    class = classnames([@sidebar_nav_classes, assigns[:class]])
    assigns = assign(assigns, extra: extra, class: class)

    ~H"""
    <ul class={@class} {extra}>
      <%= for item <- @item do %>
        <li class={classnames(["u-margin-xs-bottom u-flex", item[:class]])}
            {assigns_to_attributes(item, [:class])}>
          <%= render_slot(item) %>
        </li>
      <% end %>
    </ul>
    """
  end

  @sidebar_section_classes "u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col"
  @sidebar_section_default_border_color "gray-70"
  def ui_sidebar_section(assigns) do
    border_color = Map.get(assigns, :border_color, @sidebar_section_default_border_color)
    border = Map.get(assigns, :border)

    class =
      classnames([
        @sidebar_section_classes,
        assigns[:class],
        {"u-border-#{border_color}-#{border} u-margin-xs-#{border}", !!border}
      ])

    extra = assigns_to_attributes(assigns, [:class, :border, :border_color])
    assigns = assign(assigns, extra: extra, class: class)

    ~H"""
    <div class={class} {extra}><%= render_block(@inner_block) %></div>
    """
  end
end
