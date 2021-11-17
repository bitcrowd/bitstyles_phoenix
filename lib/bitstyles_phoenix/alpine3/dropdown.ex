defmodule BitstylesPhoenix.Alpine3.Dropdown do
  use BitstylesPhoenix.Component

  alias BitstylesPhoenix.Component.Dropdown, as: RawDropdown

  @doc """
  Renders a dropdown component with a button, a menu and options.
  """

  story(
    "Dropdown with alpine",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 200px">
        ...>   <.ui_dropdown icon_file="assets/icons.svg">
        ...>     <:button label="Select me"/>
        ...>     <:option>
        ...>       <%= ui_button "Option 1", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>     <:option>
        ...>       <%= ui_button "Option 2", to: "#", variant: "menu", class: "u-h6" %>
        ...>     </:option>
        ...>   </.ui_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 200px">
          <div class="u-relative" x-data="{ dropdownOpen: false }">
            <button type="button" class="a-button a-button--ui u-h6" @click="dropdownOpen = true">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="assets/icons.svg#icon-caret-down">
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
    """
  )

  def ui_dropdown(assigns) do
    button_assigns = assigns_from_single_slot(assigns, :button, with: :button_extra)

    menu_assigns =
      assigns_from_single_slot(assigns, :menu, with: :menu_extra, default: [menu_extra: %{}])

    extra = assigns_to_attributes(assigns, [:menu, :button, :x_name])

    assigns =
      assigns
      |> assign(extra: extra, x_name: assigns[:x_name] || "dropdownOpen")
      |> assign(button_assigns)
      |> assign(menu_assigns)

    ~H"""
    <RawDropdown.ui_dropdown x-data={"{ #{@x_name}: false }"} {@extra}>
      <:button @click={"#{@x_name} = true"} {@button_extra}><%= render_slot(@button) %></:button>
      <:menu x-show={@x_name} @click.away={"#{@x_name} = false"} {@menu_extra} />
    </RawDropdown.ui_dropdown>
    """
  end
end
