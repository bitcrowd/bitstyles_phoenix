defmodule BitstylesPhoenix.Alpine3.Dropdown do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Dropdown, as: RawDropdown

  @moduledoc """
  Components for rendering a dropdown menu powered by Alpine 3.
  """

  @doc """
  Renders a dropdown component with a button, a menu and options with Alpine3.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Dropdown.ui_dropdown`.

  ## Attributes
  - `x_name` - The name of the boolean x-data property for alpine to store the menu state.
    Defaults to `dropdownOpen`.

  ## Prevent page-flickering

  The dropdown sets the `x-cloak` property on the menu to avoid flickering on initial page load.
  To make this work, you need to add the following snippet to your stylesheets:

     [x-cloak] { display: none !important; }

  See https://alpinejs.dev/directives/cloak for more information on `x-cloak`.
  """

  story(
    "Dropdown with alpine",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_js_dropdown>
        ...>   <:button label="Select me"/>
        ...>   <:menu>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 1
        ...>     </.ui_dropdown_option>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 2
        ...>     </.ui_dropdown_option>
        ...>   </:menu>
        ...> </.ui_js_dropdown>
        ...> """
    ''',
    '''
        """
        <div class="u-relative" x-data="{ dropdownOpen: false }">
          <button type="button" @click="dropdownOpen = true" class="a-button a-button--secondary">
            <span class="a-button__label">
              Select me
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
              <use xlink:href="#icon-caret-down">
              </use>
            </svg>
          </button>
          <ul class="a-dropdown u-overflow-y-auto u-list-none u-margin-s-top" @click.away="dropdownOpen = false" x-cloak="x-cloak" x-show="dropdownOpen" x-transition:enter="is-transitioning" x-transition:enter-end="is-on-screen" x-transition:enter-start="is-off-screen" x-transition:leave="is-transitioning" x-transition:leave-end="is-off-screen" x-transition:leave-start="is-on-screen">
            <li>
              <a href="#" class="a-button a-button--transparent a-button--menu u-h6">
                Option 1
              </a>
            </li>
            <li>
              <a href="#" class="a-button a-button--transparent a-button--menu u-h6">
                Option 2
              </a>
            </li>
          </ul>
        </div>
        """
    ''',
    extra_html: """
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.5.1/cdn.min.js" defer></script>
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-down" viewBox="0 0 100 100">
        <path d="M6.64,34.23a5.57,5.57,0,0,1,7.87-7.89L49.92,61.91,85.49,26.34a5.57,5.57,0,0,1,7.87,7.89L53.94,73.66a5.58,5.58,0,0,1-7.88,0Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """,
    height: "200px"
  )

  story(
    "Custom x-data name and icon file",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_js_dropdown x_name="myOwnDropDown">
        ...>   <:button label="Select me" icon_file="assets/icons.svg"/>
        ...>   <:menu>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 1
        ...>     </.ui_dropdown_option>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 2
        ...>     </.ui_dropdown_option>
        ...>   </:menu>
        ...> </.ui_js_dropdown>
        ...> """
    ''',
    '''
        """
        <div class="u-relative" x-data="{ myOwnDropDown: false }">
          <button type="button" @click="myOwnDropDown = true" class="a-button a-button--secondary">
            <span class="a-button__label">
              Select me
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
              <use xlink:href="assets/icons.svg#icon-caret-down">
              </use>
            </svg>
          </button>
          <ul class="a-dropdown u-overflow-y-auto u-list-none u-margin-s-top" @click.away="myOwnDropDown = false" x-cloak="x-cloak" x-show="myOwnDropDown" x-transition:enter="is-transitioning" x-transition:enter-end="is-on-screen" x-transition:enter-start="is-off-screen" x-transition:leave="is-transitioning" x-transition:leave-end="is-off-screen" x-transition:leave-start="is-on-screen">
            <li>
              <a href="#" class="a-button a-button--transparent a-button--menu u-h6">
                Option 1
              </a>
            </li>
            <li>
              <a href="#" class="a-button a-button--transparent a-button--menu u-h6">
                Option 2
              </a>
            </li>
          </ul>
        </div>
        """
    ''',
    extra_html: """
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.5.1/cdn.min.js" defer></script>
    """,
    height: "200px"
  )

  def ui_js_dropdown(assigns) do
    {_button, button_extra} = assigns_from_single_slot(assigns, :button)

    {_menu, menu_extra} = assigns_from_single_slot(assigns, :menu)

    extra = assigns_to_attributes(assigns, [:menu, :button, :x_name])

    assigns =
      assigns
      |> assign(extra: extra, button_extra: button_extra, menu_extra: menu_extra)
      |> assign_new(:x_name, fn -> "dropdownOpen" end)

    ~H"""
    <RawDropdown.ui_dropdown x-data={"{ #{@x_name}: false }"} {@extra}>
      <:button @click={"#{@x_name} = true"} {@button_extra}><%= render_slot(@button) %></:button>
      <:menu
        x-cloak
        x-show={@x_name}
        @click.away={"#{@x_name} = false"}
        x-transition:enter="is-transitioning"
        x-transition:enter-start="is-off-screen"
        x-transition:enter-end="is-on-screen"
        x-transition:leave="is-transitioning"
        x-transition:leave-start="is-on-screen"
        x-transition:leave-end="is-off-screen"
        {@menu_extra}>
        <%= render_slot(@menu) %>
      </:menu>
    </RawDropdown.ui_dropdown>
    """
  end
end
