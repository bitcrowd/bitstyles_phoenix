defmodule BitstylesPhoenix.Component.Heading do
  use BitstylesPhoenix.Component

  @moduledoc """
  Components for building headings.
  """

  @doc ~s"""
  Render a page header with a `<h1>` title and an optional `title_extra` and some `action` slots
  for that page (usually combined with buttons and dropdowns).

  ## Attributes
  - `class` - Set CSS classes on the outer div.
  - All other attributes are passed to the outer `div` tag.

  ## Attributes - `title_extra` slot
  - `class` - Set CSS classes on the surrounding div.
  - All other attributes are passed to the outer `div` tag.

  ## Attributes - `action` slots
  - `class` - Set CSS classes on the surrounding `li`.
  - `show` - If the action should be rendered. Defaults to `true`.
  - All other attributes are passed to the outer `li` tag.

  See [the page header docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-content-page-header--page-header)
  for more examples and details.
  """

  story(
    "Page title",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_page_title>
        ...>   Title
        ...> </.ui_page_title>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-justify-between u-flex-wrap u-items-center">
          <div class="u-flex u-flex-wrap u-items-center">
            <h1 class="u-margin-m-right u-break-text">
              Title
            </h1>
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Page title with actions and title extra",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_page_title>
        ...>   Title
        ...>   <:title_extra>
        ...>     <.ui_badge>Published</.ui_badge>
        ...>   </:title_extra>
        ...>   <:action>
        ...>     <.ui_button>Edit</.ui_button>
        ...>   </:action>
        ...>   <:action>
        ...>     <.ui_button color="danger">Delete</.ui_button>
        ...>   </:action>
        ...>   <:action show={false}>
        ...>     <.ui_button color="danger">Hide me</.ui_button>
        ...>   </:action>
        ...> </.ui_page_title>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-justify-between u-flex-wrap u-items-center">
          <div class="u-flex u-flex-wrap u-items-center">
            <h1 class="u-margin-m-right u-break-text">
              Title
            </h1>
            <div class="u-flex-shrink-0 u-margin-m-bottom">
              <span class="a-badge u-h6 u-font-medium a-badge--text">
                Published
              </span>
            </div>
          </div>
          <ul class="u-list-none u-flex u-flex-wrap">
            <li class="u-margin-s-right u-margin-m-bottom">
              <button type="button" class="a-button">
                Edit
              </button>
            </li>
            <li class="u-margin-s-right u-margin-m-bottom">
              <button type="button" class="a-button a-button--danger">
                Delete
              </button>
            </li>
          </ul>
        </div>
        """
    ''',
    width: "100%",
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-down" viewBox="0 0 100 100">
        <path d="M6.64,34.23a5.57,5.57,0,0,1,7.87-7.89L49.92,61.91,85.49,26.34a5.57,5.57,0,0,1,7.87,7.89L53.94,73.66a5.58,5.58,0,0,1-7.88,0Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  def ui_page_title(assigns) do
    class = classnames(["u-flex u-justify-between u-flex-wrap u-items-center", assigns[:class]])
    extra = assigns_to_attributes(assigns, [:class, :action, :title_extra])

    assigns = assign(assigns, class: class, extra: extra)

    ~H"""
    <div class={@class} {@extra}>
      <div class={classnames("u-flex u-flex-wrap u-items-center")}>
        <h1 class={classnames("u-margin-m-right u-break-text")}><%= render_slot(@inner_block) %></h1>
        <%= if assigns[:title_extra] do %>
          <div class={classnames(["u-flex-shrink-0 u-margin-m-bottom", @title_extra[:class]])} {assigns_to_attributes(@title_extra, [:class])}>
             <%= render_slot(@title_extra) %>
          </div>
        <% end %>
      </div>
      <%= if assigns[:action] do %>
        <.ui_action_buttons action={@action}/>
      <% end %>
    </div>
    """
  end

  @section_default_border_color "gray-light"

  @doc ~s"""
  Render a section header with optional `action`s and `title_extra`.

  ## Attributes
  - `class` - Set CSS classes on the outer div.
  - `border` - Controls the bottom border and padding (default: true, boolean)
  - `border_color` - The border color, defaults to `gray-light` resulting in `u-border-gray-light-bottom`.
  - `tag` - the heading tag (defaults to h3)
  - `heading_class` - Extra classes on the heading
  - All other attributes are passed to the outer `div` tag.

  ## Attributes - `title_extra` slot
  - `class` - Set CSS classes on the surrounding div.
  - All other attributes are passed to the outer `div` tag.

  ## Attributes - `action` slots
  - `class` - Set CSS classes on the surrounding `li`.
  - `show` - If the action should be rendered. Defaults to `true`.
  - All other attributes are passed to the outer `li` tag.
  """

  story(
    "Section title with default border",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_section_title>
        ...>   Section title
        ...> </.ui_section_title>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-flex-wrap u-items-center u-justify-between u-padding-m-bottom u-border-gray-light-bottom">
          <div class="u-flex u-items-center">
            <h3 class="u-margin-0 u-margin-m-right u-break-text">
              Section title
            </h3>
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Section title without border and h2",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_section_title border={false} tag={:h2}>
        ...>   Section title
        ...> </.ui_section_title>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-flex-wrap u-items-center u-justify-between">
          <div class="u-flex u-items-center">
            <h2 class="u-margin-0 u-margin-m-right u-break-text">
              Section title
            </h2>
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Section title with actions and title extra and different border",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_section_title border_color="gray-light" heading_class="extra">
        ...>   Section title
        ...>   <:title_extra>
        ...>     <.ui_badge>Published</.ui_badge>
        ...>   </:title_extra>
        ...>   <:action>
        ...>     <.ui_button>Edit</.ui_button>
        ...>   </:action>
        ...>   <:action>
        ...>     <.ui_button color="danger">Delete</.ui_button>
        ...>   </:action>
        ...>   <:action show={false}>
        ...>     <.ui_button color="danger">Hide me</.ui_button>
        ...>   </:action>
        ...> </.ui_section_title>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-flex-wrap u-items-center u-justify-between u-padding-m-bottom u-border-gray-light-bottom">
          <div class="u-flex u-items-center">
            <h3 class="u-margin-0 u-margin-m-right u-break-text extra">
              Section title
            </h3>
            <span class="a-badge u-h6 u-font-medium a-badge--text">
              Published
            </span>
          </div>
          <ul class="u-list-none u-flex u-flex-wrap">
            <li class="u-margin-s-right u-margin-m-bottom">
              <button type="button" class="a-button">
                Edit
              </button>
            </li>
            <li class="u-margin-s-right u-margin-m-bottom">
              <button type="button" class="a-button a-button--danger">
                Delete
              </button>
            </li>
          </ul>
        </div>
        """
    ''',
    width: "100%"
  )

  def ui_section_title(assigns) do
    border_color = Map.get(assigns, :border_color, @section_default_border_color)
    border = Map.get(assigns, :border, true)

    class =
      classnames([
        "u-flex u-flex-wrap u-items-center u-justify-between",
        {"u-padding-m-bottom u-border-#{border_color}-bottom", border},
        assigns[:class]
      ])

    extra =
      assigns_to_attributes(assigns, [
        :class,
        :action,
        :title_extra,
        :tag,
        :border,
        :border_color,
        :heading_class
      ])

    assigns = assigns |> assign(class: class, extra: extra) |> assign_new(:tag, fn -> :h3 end)

    ~H"""
      <div class={@class} {@extra}>
        <div class={classnames("u-flex u-items-center")}>
          <.dynamic_tag name={@tag} class={classnames(["u-margin-0 u-margin-m-right u-break-text", assigns[:heading_class]])}>
            <%= render_slot(@inner_block) %>
          </.dynamic_tag>
          <%= assigns[:title_extra] && render_slot(@title_extra) %>
        </div>
        <%= if assigns[:action] do %>
          <.ui_action_buttons action={@action}/>
        <% end %>
      </div>
    """
  end

  defp ui_action_buttons(assigns) do
    ~H"""
    <ul class={classnames("u-list-none u-flex u-flex-wrap")}>
      <%= for action <- @action do %>
        <%= if Map.get(action, :show, true) do %>
          <li class={classnames(["u-margin-s-right u-margin-m-bottom", action[:class]])} {assigns_to_attributes(action, [:class, :show])}>
            <%= render_slot(action) %>
          </li>
        <% end %>
      <% end %>
    </ul>
    """
  end
end
