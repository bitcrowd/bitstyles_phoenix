defmodule BitstylesPhoenix.Alpine3.Dropdown do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Dropdown, as: RawDropdown

  @doc """
  Renders a dropdown component with a button, a menu and options with Alpine3.

  Supports all attributes and slots from `BitstylesPhoenix.Component.Dropdown.ui_dropdown`.

  ## Attributes
  - `x_name` - The name of the boolean x-data property for alpine to store the menu state.
    Defaults to `dropdownOpen`.
  """

  story(
    "Dropdown with alpine",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 200px">
        ...>   <.ui_js_dropdown>
        ...>     <:button label="Select me"/>
        ...>     <:option>
        ...>       <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>     <:option>
        ...>       <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>   </.ui_js_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 200px">
          <div class="u-relative" x-data="{ dropdownOpen: false }">
            <button @click="dropdownOpen = true" class="a-button a-button--ui" type="button">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow--y a-list-reset u-margin-s-top" @click.away="dropdownOpen = false" x-show="dropdownOpen">
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
        </div>
        """
    ''',
    extra_html: """
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.5.1/cdn.min.js"></script>
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-down" viewBox="0 0 100 100">
        <path d="M6.64,34.23a5.57,5.57,0,0,1,7.87-7.89L49.92,61.91,85.49,26.34a5.57,5.57,0,0,1,7.87,7.89L53.94,73.66a5.58,5.58,0,0,1-7.88,0Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Custom x-data name and icon file",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 200px">
        ...>   <.ui_js_dropdown x_name="myOwnDropDown" icon_file="assets/icons.svg">
        ...>     <:button label="Select me"/>
        ...>     <:option>
        ...>       <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>     <:option>
        ...>       <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>   </.ui_js_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 200px">
          <div class="u-relative" x-data="{ myOwnDropDown: false }">
            <button @click="myOwnDropDown = true" class="a-button a-button--ui" type="button">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="assets/icons.svg#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow--y a-list-reset u-margin-s-top" @click.away="myOwnDropDown = false" x-show="myOwnDropDown">
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
        </div>
        """
    ''',
    extra_html: """
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.5.1/cdn.min.js"></script>
    """
  )

  def ui_js_dropdown(assigns) do
    {_button, button_extra} = assigns_from_single_slot(assigns, :button)

    {_menu, menu_extra} =
      assigns_from_single_slot(assigns, :menu, with: :menu_extra, optional: true)

    extra = assigns_to_attributes(assigns, [:menu, :button, :x_name])

    assigns =
      assigns
      |> assign(extra: extra, button_extra: button_extra, menu_extra: menu_extra)
      |> assign_new(:x_name, fn -> "dropdownOpen" end)

    ~H"""
    <RawDropdown.ui_dropdown x-data={"{ #{@x_name}: false }"} {@extra}>
      <:button @click={"#{@x_name} = true"} {@button_extra}><%= render_slot(@button) %></:button>
      <:menu x-show={@x_name} @click.away={"#{@x_name} = false"} {@menu_extra} />
    </RawDropdown.ui_dropdown>
    """
  end
end
