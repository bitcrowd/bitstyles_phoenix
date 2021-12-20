defmodule BitstylesPhoenix.Component.Button do
  use BitstylesPhoenix.Component

  @moduledoc """
  The button component.
  """

  import BitstylesPhoenix.Helper.Button

  @doc """
  This wraps `BitstylesPhoenix.Helper.Button.ui_button/2` in a component,
  passing all attributes as options and it's content as button content.

  See `BitstylesPhoenix.Helper.Button.ui_button/2` for more examples and options.
  """

  story("Default button", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button>
      ...>   Publish
      ...> </.ui_button>
      ...> """
      """
      <button class="a-button" type="button">
        Publish
      </button>
      """
  ''')

  story("Default link", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button to="/" variant="ui">
      ...>   Publish
      ...> </.ui_button>
      ...> """
      """
      <a class="a-button a-button--ui" href="/">
        Publish
      </a>
      """
  ''')

  def ui_button(assigns) do
    ~H"""
    <%= ui_button(assigns_to_attributes(assigns)) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  @doc """
  This wraps `BitstylesPhoenix.Helper.Button.ui_icon_button/3` in a component.

  ## Attributes
  - `icon` - An icon name as string or a tuple of {name, icon_opts} to be passed on.
  - `label` - A screen reader label for the button.
  - All other attributes are passed in as options to `BitstylesPhoenix.Helper.Button.ui_icon_button/3`.

  See `BitstylesPhoenix.Helper.Button.ui_icon_button/3` for more examples and options.
  """

  story(
    "Icon button",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon_button icon="plus" label="Add" to="#"/>
        ...> """
        """
        <a class="a-button a-button--icon" href="#" title="Add">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
          <span class="u-sr-only">
            Add
          </span>
        </a>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-plus" viewBox="0 0 100 100">
        <path d="M54.57,87.43V54.57H87.43a4.57,4.57,0,0,0,0-9.14H54.57V12.57a4.57,4.57,0,1,0-9.14,0V45.43H12.57a4.57,4.57,0,0,0,0,9.14H45.43V87.43a4.57,4.57,0,0,0,9.14,0Z"/>
      </symbol>
    </svg>
    """
  )

  story("Icon button with some options", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_icon_button icon={{"bin", file: "assets/icons.svg", size: "xl"}} label="Delete" class="foo" />
      ...> """
      """
      <button class="a-button a-button--icon foo" title="Delete" type="button">
        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--xl" focusable="false" height="16" width="16">
          <use xlink:href="assets/icons.svg#icon-bin">
          </use>
        </svg>
        <span class="u-sr-only">
          Delete
        </span>
      </button>
      """
  ''')

  def ui_icon_button(assigns) do
    ~H"""
    <%= ui_icon_button(@icon, @label, assigns_to_attributes(assigns, [:icon, :label])) %>
    """
  end
end
