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
        ...>       <.ui_sidebar_nav_item><.ui_button href="#" class="u-flex-grow-1" color="transparent">Menu item #1</.ui_button></.ui_sidebar_nav_item>
        ...>       <.ui_sidebar_nav_item><.ui_button href="#" class="u-flex-grow-1" color="transparent">Menu item #2</.ui_button></.ui_sidebar_nav_item>
        ...>     </.ui_sidebar_nav>
        ...>     <.ui_sidebar_section border="top">
        ...>       <.ui_dropdown variant={["top", "full-width"]}>
        ...>         <:button color="transparent">
        ...>           <div class="a-button__icon a-avatar">
        ...>             <img src="https://placehold.co/100x150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar" />
        ...>           </div>
        ...>           <span class="a-button__label">Jane Dobermann</span>
        ...>         </:button>
        ...>         <:menu>
        ...>           <.ui_dropdown_option href="#">Logout</.ui_dropdown_option>
        ...>         </:menu>
        ...>       </.ui_dropdown>
        ...>     </.ui_sidebar_section>
        ...>   </:sidebar_content>
        ...>   Main Content
        ...> </.ui_sidebar_layout>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg-gray-darker u-fg-text-light">
                Large header
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-bottom u-margin-xs-bottom">
                  Menu
                </div>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow-y-auto a-list-reset u-flex u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left">
                  <li class="u-margin-xs-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-xs-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #2
                    </a>
                  </li>
                </ul>
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-top u-margin-xs-top">
                  <div class="u-relative">
                    <button type="button" class="a-button a-button--transparent">
                      <div class="a-button__icon a-avatar">
                        <img src="https://placehold.co/100x150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar"/>
                      </div>
                      <span class="a-button__label">
                        Jane Dobermann
                      </span>
                    </button>
                    <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--top a-dropdown--full-width u-margin-s-bottom">
                      <li>
                        <a href="#" class="a-button a-button--menu">
                          Logout
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg-gray-darker u-fg-text-light">
                Small header
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-bottom u-margin-xs-bottom">
                  Menu
                </div>
                <ul class="u-flex-grow-1 u-flex-shrink-1 u-overflow-y-auto a-list-reset u-flex u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left">
                  <li class="u-margin-xs-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #1
                    </a>
                  </li>
                  <li class="u-margin-xs-bottom u-flex">
                    <a href="#" class="a-button a-button--transparent u-flex-grow-1">
                      Menu item #2
                    </a>
                  </li>
                </ul>
                <div class="u-flex-shrink-0 u-padding-xs-y u-margin-xs-left u-margin-xs-right u-flex u-flex-col u-border-gray-70-top u-margin-xs-top">
                  <div class="u-relative">
                    <button type="button" class="a-button a-button--transparent">
                      <div class="a-button__icon a-avatar">
                        <img src="https://placehold.co/100x150" width="36" height="54" alt="Jane Dobermann’s avatar" class="a-avatar"/>
                      </div>
                      <span class="a-button__label">
                        Jane Dobermann
                      </span>
                    </button>
                    <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--top a-dropdown--full-width u-margin-s-bottom">
                      <li>
                        <a href="#" class="a-button a-button--menu">
                          Logout
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow-y-auto">
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

  The sidebar comes with 4 slots:
    - `large_sidebar` - Content that is only shown on large screens in the sidebar
    - `small_sidebar` - Content that is only shown on small screens in the sidebar
    - `sidebar_content` - Content that is shown on all screens in the sidebar
    - `main` - The main content of the page (next to the sidebar)

  Instead of the `main` slot you can also just use the inner content of the sidebar, but the slot
  is valuable if you want to provide extra attributes on the `main` tag.
  The `large_siebar` and `small_sidebar` slots are displayed before the `sidebar_content` in the layout,
  since typically they host the logo/header/brand name, while the main navigation is hosted in the
  `sidebar_content` slot and shown on all screens. The reason for this separation is that the sidebar
  in the small screen is meant to start out hidden and only be shown when needed and therefore needs
  control buttons to close it again (ususally at the top of the screen).
  If you have different requirements you can simply omit the `sidebar_content` block and render the
  shared content twice yourself.

  # Attributes - `small_sidebar` slot

  - `class` - Extra classes to pass to the div containing the small sidebar
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `fg` - The forground color class for the text. Defaults to `gray-30` resulting in `fg-gray-30`.
  - `bg` - The background color class for the sidebar. Defaults to `gray-80` resulting in `fg-gray-80`.
  - All other attributes are passed on to the small sidebar `div`

  # Attributes - `large_sidebar` slot

  - `class` - Extra classes to pass to the div containing the large sidebar
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `fg` - The forground color class for the text. Defaults to `gray-30` resulting in `fg-gray-30`.
  - `bg` - The background color class for the sidebar. Defaults to `gray-80` resulting in `fg-gray-80`.
  - All other attributes are passed on to the large sidebar `div`

  # Attributes - `sidebar_content` slot

  - `class` - Extra classes to pass to the div containing the large and small sidebar
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the large and small sidebar `div`s

  # Attributes - `main` slot

  - `class` - Extra classes to pass to the `main` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the main tag.

  See the [bitstyles sidebar docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-navigation-sidebar--sidebar) for more examples.
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
    ''',
    '''
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg-gray-darker u-fg-text-light">
                Large header
                <div>
                  Sidebar
                </div>
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg-gray-darker u-fg-text-light">
                Small header
                <div>
                  Sidebar
                </div>
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow-y-auto">
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
    ''',
    '''
        """
        <div class="u-flex u-height-100vh">
          <header role="banner" class="u-flex">
            <nav class="u-flex">
              <div class="u-hidden o-sidebar--large u-flex-shrink-0 u-padding-m-top u-flex@l u-flex-col u-bg-gray-darker u-fg-text-light">
              </div>
              <div class="o-sidebar--small u-flex u-flex-col u-hidden@l u-bg-gray-darker u-fg-text-light">
              </div>
            </nav>
          </header>
          <main class="u-flex-grow-1 u-overflow-y-auto">
            Main Content
          </main>
        </div>
        """
    ''',
    width: "100%",
    height: "300px",
    transparent: false
  )

  @default_bg "gray-darker"
  @default_fg "text-light"
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

    {main, main_extra} =
      assigns_from_single_slot(assigns, :main, exclude: [:class], optional: true)

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
        main_class: classnames(["u-flex-grow-1 u-overflow-y-auto", main[:class]]),
        large_class: sidebar_classnames(large_sidebar, sidebar, @large_classes),
        small_class: sidebar_classnames(small_sidebar, sidebar, @small_classes)
      )

    ~H"""
      <div class={@class} {@extra}>
        <header role="banner" class={classnames("u-flex")}>
          <nav class={classnames("u-flex")}>
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
        <main class={@main_class} {@main_extra}>
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
      {"u-bg-#{bg}", !!bg},
      {"u-fg-#{fg}", !!fg},
      sidebar[:class],
      sidebar_layout[:class]
    ])
  end

  @doc """
  A navigation menu for usage in the sidebar.

  ## Attributes

  - `class` - Extra classes to pass to the outer `ul`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the outer `ul`

  You can add items `ui_sidebar_nav_item/1` to add items to the navigation.
  """
  @sidebar_nav_classes "u-flex-grow-1 u-flex-shrink-1 u-overflow-y-auto a-list-reset u-flex " <>
                         "u-flex-col u-items-stretch u-padding-xs-right u-padding-xs-left"
  def ui_sidebar_nav(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    class = classnames([@sidebar_nav_classes, assigns[:class]])
    assigns = assign(assigns, extra: extra, class: class)

    ~H"""
    <ul class={@class} {@extra}>
      <%= render_slot(@inner_block) %>
    </ul>
    """
  end

  @doc """
  A navigation menu item for usage in `ui_sidebar_nav/1`.

  ## Attributes

  - `class` - Extra classes to pass to the `li`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.

  The component is meant to be used with `ui_button` to add links here like showcased in the
  top level module documentation.
  """
  def ui_sidebar_nav_item(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    class = classnames(["u-margin-xs-bottom u-flex", assigns[:class]])
    assigns = assign(assigns, extra: extra, class: class)

    ~H"""
    <li class={@class} {@extra}>
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  @doc """
  A navigation section with a bottom or top border.
  See top level module doc for an example.

  ## Attributes

  - `class` - Extra classes to pass to the outer `div`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `border` - Either `:top` or `:bottom` (optional)
  - `border_color` - The border color, defaults to `gray-70` resulting in
     `u-border-gray-70-top` for a `:top` border.
  - All other attributes are passed on to the outer `div`
  """

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
    <div class={@class} {@extra}><%= render_slot(@inner_block) %></div>
    """
  end
end
