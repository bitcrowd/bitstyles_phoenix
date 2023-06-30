defmodule BitstylesPhoenix.Component.Nav do
  use BitstylesPhoenix.Component

  @moduledoc """
  A Nav component.
  """

  @doc ~S"""
  Renders a nav component.

  A top-level navigation container, with two sections separated to the left & right.
  The left-hand side is commonly used for a logo and links, the right-hand side for user account menu and global search.

  See the [bitstyles nav docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-navigation-navbar--navbar) for further info.
  """

  story(
    "Default navbar",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_nav(logo_url: "https://placekitten.com/100/100")></.ui_nav>
        ...> """
        """
        <div class="u-bg-gray-80 u-width-full u-padding-s2-top u-padding-s2-bottom u-relative">
          <div class="u-padding-m-x u-flex u-justify-between u-items-center u-flex-wrap">
            <div class="u-flex-shrink-1 u-flex u-items-center">
              <img src="https://placekitten.com/150/50" width="150" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden u-block@l" />
              <img src="https://placekitten.com/50/50" width="50" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden@l" />
            </div>
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Navbar with list of buttons",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_nav(logo_url: "https://placekitten.com/100/100")>
        ...>  <:inner_block>
        ...>     <div class="u-hidden u-block@l u-flex-shrink-1 u-overflow-x-auto">
        ...>      <ul class="u-flex u-list-none">
        ...>        <li class="u-margin-m-right">
        ...>          <a href="/" class="a-button a-button--transparent" aria-current="page">Team</a>
        ...>        </li>
        ...>        <li class="u-margin-m-right">
        ...>          <a href="/" class="a-button a-button--transparent">Projects</a>
        ...>        </li>
        ...>        <li class="u-margin-m-right">
        ...>          <a href="/" class="a-button a-button--transparent">Dashboard</a>
        ...>        </li>
        ...>      </ul>
        ...>     </div>
        ...>   </:inner_block>
        ...> </.ui_nav>
        ...> """
        """
        <div class="u-bg-gray-80 u-width-full u-padding-s2-top u-padding-s2-bottom u-relative">
          <div class="u-padding-m-x u-flex u-justify-between u-items-center u-flex-wrap">
            <div class="u-flex-shrink-1 u-flex u-items-center">
              <img src="https://placekitten.com/150/50" width="150" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden u-block@l" />
              <img src="https://placekitten.com/50/50" width="50" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden@l" />
            </div>
            <div class="u-flex-shrink-1 u-overflow-x-auto">
              <ul class="u-flex u-list-none">
                <li class="u-margin-m-right">
                  <a href="/" class="a-button a-button--transparent" aria-current="page">Team</a>
                </li>
                <li class="u-margin-m-right">
                  <a href="/" class="a-button a-button--transparent">Projects</a>
                </li>
                <li class="u-margin-m-right">
                  <a href="/" class="a-button a-button--transparent">Dashboard</a>
                </li>
              </ul>
            </div>
            </div>
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Navbar with left block",
    '''
          iex> assigns = %{}
          ...> render ~H"""
          ...> <.ui_nav(logo_url: "https://placekitten.com/100/100")>
          ...>  <:left_block>
          ...>     Content
          ...>   </:left_block>
          ...> </.ui_nav>
          ...> """
          """
          <div class="u-bg-gray-80 u-width-full u-padding-s2-top u-padding-s2-bottom u-relative">
            <div class="u-padding-m-x u-flex u-justify-between u-items-center u-flex-wrap">
              <div class="u-flex-shrink-1 u-flex u-items-center">
                <img src="https://placekitten.com/150/50" width="150" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden u-block@l" />
                <img src="https://placekitten.com/50/50" width="50" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden@l" />
              </div>
              <div class="u-fg-white u-margin-s-left items-end">
                <p class="">Left Block</p>
              </div>
            </div>
          </div>
          """
    ''',
    width: "100%"
  )

  def ui_nav(assigns) do
    class =
      classnames([
        "u-bg-gray-80 u-padding-s2-top u-padding-s2-bottom u-width-full u-relative",
        assigns[:class]
      ])

    inner_block_class =
      classnames([
        "u-margin-s-left",
        assigns[:inner_block_class]
      ])

    left_block_class =
      classnames([
        "u-margin-s-left items-end",
        assigns[:left_block_class]
      ])

    assigns =
      assign(assigns,
        class: class,
        inner_block_class: inner_block_class,
        left_block_class: left_block_class
      )

    ~H"""
    <nav class={@class}>
      <div class={classnames("u-padding-m-x u-flex u-justify-between u-items-center u-flex-wrap")}>
      <div class={classnames("u-flex-shrink-1 u-flex u-items-center")}>
        <%= if assigns[:logo_url] do %>
              <img src={assigns[:logo_url]} width="150" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden u-block@l" />
              <img src={assigns[:logo_url]} width="50" height="50" alt="Company logo" class="u-flex-shrink-0 u-margin-l2-right u-hidden@l" />
        <% end %>
        <%= if assigns[:inner_block] do %>
          <div class={@inner_block_class}>
          <%= render_slot(@inner_block) %>
          </div>
        <% end %>
        <%= if assigns[:left_block] do %>
          <div class={@left_block_class}>
            <%= render_slot(@left_block) %>
          </div>
        <% end %>
      </div>
      </div>
    </nav>
    """
  end
end
