defmodule BitstylesPhoenix.Component.Dropdown do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Icon

  @moduledoc """
  The dropdown component without any JS.
  """

  @doc """
  Renders a dropdown component with a button, a menu and options.

  *In order for this component to work you have to provide extra JS like shown in the examples.*

  The dropdown supports a default button that can either render with a label and a icon or with completly custom content.
  It also supports an optional menu slot, to add attributes on the menu (the content of the menu is not rendered).

  The dropdown options can be passed in as slots, which will be passed down to the menu items.
  You can use `ui_button` with variant `menu` to render links that are prepared for the dropdown menu.
  """

  story(
    "Minimal dropdown with defaults without JS ",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dropdown>
        ...>   <:button label="Select me"/>
        ...>   <:option>
        ...>     <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>   </:option>
        ...>   <:option>
        ...>     <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>   </:option>
        ...> </.ui_dropdown>
        ...> """
        """
        <div class="u-relative">
          <button type="button" class="a-button a-button--ui u-h6">
            <span class="a-button__label">
              Select me
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
              <use xlink:href="#icon-caret-down">
              </use>
            </svg>
          </button>
          <ul class="a-dropdown u-overflow--y a-list-reset u-margin-s-top">
            <li>
              <a class="a-button a-button--menu u-h6" href="#">
                Option 1
              </a>
            </li>
            <li>
              <a class="a-button a-button--menu u-h6" href="#">
                Option 2
              </a>
            </li>
          </ul>
        </div>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-down" viewBox="0 0 100 100">
        <path d="M6.64,34.23a5.57,5.57,0,0,1,7.87-7.89L49.92,61.91,85.49,26.34a5.57,5.57,0,0,1,7.87,7.89L53.94,73.66a5.58,5.58,0,0,1-7.88,0Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Custom button content",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dropdown>
        ...>   <:button class="foo">Custom button content</:button>
        ...>   <:option>
        ...>     <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>   </:option>
        ...>   <:option>
        ...>     <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>   </:option>
        ...> </.ui_dropdown>
        ...> """
        """
        <div class="u-relative">
          <button type="button" class="a-button a-button--ui u-h6 foo">
            Custom button content
          </button>
          <ul class="a-dropdown u-overflow--y a-list-reset u-margin-s-top">
            <li>
              <a class="a-button a-button--menu u-h6" href="#">
                Option 1
              </a>
            </li>
            <li>
              <a class="a-button a-button--menu u-h6" href="#">
                Option 2
              </a>
            </li>
          </ul>
        </div>
        """
    '''
  )

  story(
    "Drop down with default button and custom options on the menu and some JS",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 200px">
        ...>   <.ui_dropdown icon_file="assets/icons.svg">
        ...>     <:button onclick="toggle('dropdown-1')" aria-controls={"dropdown-1"} label="Select me"/>
        ...>     <:menu style="display: none" id="dropdown-1"/>
        ...>     <:option class="foo">
        ...>       <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>     <:option>
        ...>       <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>     <:option role="separator"></:option>
        ...>     <:option>
        ...>       <%= ui_button "Option 3", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>   </.ui_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 200px">
          <div class="u-relative">
            <button type="button" class="a-button a-button--ui u-h6" aria-controls="dropdown-1" onclick=\"toggle(&#39;dropdown-1&#39;)\">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="assets/icons.svg#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow--y a-list-reset u-margin-s-top" id="dropdown-1" style="display: none">
              <li class="foo">
                <a class="a-button a-button--menu u-h6" href="#">
                  Option 1
                </a>
              </li>
              <li>
                <a class="a-button a-button--menu u-h6" href="#">
                  Option 2
                </a>
              </li>
              <li role="separator">
              </li>
              <li>
                <a class="a-button a-button--menu u-h6" href="#">
                  Option 3
                </a>
              </li>
            </ul>
          </div>
        </div>
        """
    ''',
    extra_html: """
    <script>
      function toggle(element) {
        var e = document.getElementById(element);
        if (e.style.display === "none") {
          e.style.display = "block";
        } else {
          e.style.display = "none";
        }
      }
    </script>
    """
  )

  @menu_class "a-dropdown u-overflow--y a-list-reset u-margin-s-top"

  def ui_dropdown(assigns) do
    button_assigns =
      assigns_from_single_slot(assigns, :button,
        exclude: [:class, :label],
        with: fn button, extra ->
          [
            button_extra: extra,
            button_label: button[:label],
            button_class: classnames(["a-button a-button--ui u-h6", button[:class]])
          ]
        end
      )

    menu_assigns =
      assigns_from_single_slot(assigns, :menu,
        exclude: [:class],
        default: [menu_class: @menu_class, menu_extra: %{}],
        with: fn menu, extra ->
          [menu_extra: extra, menu_class: classnames([@menu_class, menu[:class]])]
        end
      )

    class = classnames(["u-relative", assigns[:class]])
    extra = assigns_to_attributes(assigns, [:class, :menu, :button, :option, :icon_file])

    assigns =
      assigns
      |> assign(extra: extra, class: class)
      |> assign(button_assigns)
      |> assign(menu_assigns)

    ~H"""
      <div class={@class} {@extra}>
        <button type="button" class={@button_class} {@button_extra}>
          <%= if @button_label do %>
            <span class="a-button__label"><%= @button_label %></span>
            <.ui_icon name="caret-down" class="a-button__icon" size="m" file={assigns[:icon_file]}/>
          <% else %>
            <%= render_slot(@button) %>
          <% end %>
        </button>
        <ul class={@menu_class} {@menu_extra}>
          <%= for option <- @option do %>
            <li {assigns_to_attributes(option)}>
              <%= render_slot(option) %>
            </li>
          <% end %>
        </ul>
      </div>
    """
  end
end
