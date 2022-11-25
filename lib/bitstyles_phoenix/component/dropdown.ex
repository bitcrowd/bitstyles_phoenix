defmodule BitstylesPhoenix.Component.Dropdown do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Button

  @moduledoc """
  The dropdown component without any JS.
  """

  @doc """
  Renders a dropdown component with a button and a menu.

  *In order for this component to work you have to provide extra JS like shown in the examples.*

  The dropdown supports a default button that can either render with a label and a icon or with completly custom content.
  The dropdown options can be passed to the menu slot as inner content. Options can be rendered with `ui_dropdown_option/1`.

  ## Attributes

  - `class` - Extra classes to pass to the outer `div`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `variant` - The dropdown variant (top, right, full-width).
    Can be provided as an atom, a string, a list of atoms or a list of strings.
  - All other attributes are passed on to the outer `div`

  This component will not render any inner content except slots.

  ## Attributes - `menu` slot

  - `class` - Extra classes to pass to the `ul` dropdown menu
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the outer `ul`

  This slot will render any inner content as the menu. Children are expected to be `<li>`.

  ## Attributes - `button` slot

  - `class` - Extra classes to pass to the dropdown `button`
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `label` - The button for the label. If set, will not render
    custom button content.
  - `icon_file` - The external SVG file with icons to be passed on to
    `BitstylesPhoenix.Component.Icon.ui_icon/1` for the dropdown icon.
    Only needed if SVG icons are not provided inline and if
    not rendering custom button content.

  This slot will render it's inner content when no button label is set.
  """

  story(
    "Minimal dropdown with defaults without JS ",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dropdown>
        ...>   <:button label="Select me"/>
        ...>   <:menu>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 1
        ...>     </.ui_dropdown_option>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 2
        ...>     </.ui_dropdown_option>
        ...>   </:menu>
        ...> </.ui_dropdown>
        ...> """
        """
        <div class="u-relative">
          <button type="button" class="a-button a-button--ui">
            <span class="a-button__label">
              Select me
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
              <use xlink:href="#icon-caret-down">
              </use>
            </svg>
          </button>
          <ul class="a-dropdown u-overflow-y-auto a-list-reset u-margin-s-top">
            <li>
              <a href="#" class="a-button a-button--menu u-h6">
                Option 1
              </a>
            </li>
            <li>
              <a href="#" class="a-button a-button--menu u-h6">
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
    "Dropdown with menu variant top",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 150px;" class="u-flex u-flex-col">
        ...>   <div class="u-flex-grow-1"></div>
        ...>   <.ui_dropdown variant={:top}>
        ...>     <:button label="Select me"/>
        ...>     <:menu>
        ...>       <.ui_dropdown_option href="#" class="u-h6">
        ...>         Option 1
        ...>       </.ui_dropdown_option>
        ...>       <.ui_dropdown_option href="#" class="u-h6">
        ...>         Option 2
        ...>       </.ui_dropdown_option>
        ...>     </:menu>
        ...>   </.ui_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 150px;" class="u-flex u-flex-col">
          <div class="u-flex-grow-1">
          </div>
          <div class="u-relative">
            <button type="button" class="a-button a-button--ui">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--top u-margin-s-bottom">
              <li>
                <a href="#" class="a-button a-button--menu u-h6">
                  Option 1
                </a>
              </li>
              <li>
                <a href="#" class="a-button a-button--menu u-h6">
                  Option 2
                </a>
              </li>
            </ul>
          </div>
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
    "Dropdown with menu variant right",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dropdown variant="right">
        ...>   <:button label="Select me"/>
        ...>   <:menu>
        ...>     <.ui_dropdown_option href="#">
        ...>       Option 1
        ...>     </.ui_dropdown_option>
        ...>     <.ui_dropdown_option href="#">
        ...>       Option 2
        ...>     </.ui_dropdown_option>
        ...>   </:menu>
        ...> </.ui_dropdown>
        ...> """
        """
        <div class="u-relative u-flex u-justify-end">
          <button type="button" class="a-button a-button--ui">
            <span class="a-button__label">
              Select me
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
              <use xlink:href="#icon-caret-down">
              </use>
            </svg>
          </button>
          <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--right u-margin-s-top">
            <li>
              <a href="#" class="a-button a-button--menu">
                Option 1
              </a>
            </li>
            <li>
              <a href="#" class="a-button a-button--menu">
                Option 2
              </a>
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

  story(
    "Dropdown with menu variant top right",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 150px;" class="u-flex u-flex-col">
        ...>   <div class="u-flex-grow-1"></div>
        ...>   <.ui_dropdown variant={[:top, :right]}>
        ...>     <:button label="Select me"/>
        ...>     <:menu>
        ...>       <.ui_dropdown_option href="#" class="u-h6">
        ...>         Option 1
        ...>       </.ui_dropdown_option>
        ...>       <.ui_dropdown_option href="#" class="u-h6">
        ...>         Option 2
        ...>       </.ui_dropdown_option>
        ...>     </:menu>
        ...>   </.ui_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 150px;" class="u-flex u-flex-col">
          <div class="u-flex-grow-1">
          </div>
          <div class="u-relative u-flex u-justify-end">
            <button type="button" class="a-button a-button--ui">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--top a-dropdown--right u-margin-s-bottom">
              <li>
                <a href="#" class="a-button a-button--menu u-h6">
                  Option 1
                </a>
              </li>
              <li>
                <a href="#" class="a-button a-button--menu u-h6">
                  Option 2
                </a>
              </li>
            </ul>
          </div>
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

  story(
    "Custom button content",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dropdown>
        ...>   <:button class="foo">Custom button content</:button>
        ...>   <:menu>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 1
        ...>     </.ui_dropdown_option>
        ...>     <.ui_dropdown_option href="#" class="u-h6">
        ...>       Option 2
        ...>     </.ui_dropdown_option>
        ...>   </:menu>
        ...> </.ui_dropdown>
        ...> """
        """
        <div class="u-relative">
          <button type="button" class="a-button a-button--ui foo">
            Custom button content
          </button>
          <ul class="a-dropdown u-overflow-y-auto a-list-reset u-margin-s-top">
            <li>
              <a href="#" class="a-button a-button--menu u-h6">
                Option 1
              </a>
            </li>
            <li>
              <a href="#" class="a-button a-button--menu u-h6">
                Option 2
              </a>
            </li>
          </ul>
        </div>
        """
    '''
  )

  story(
    "Drop down with some JS and full-width variant and icon file",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <div style="min-height: 200px; width: 500px;">
        ...>   <.ui_dropdown variant="full-width">
        ...>     <:button onclick="toggle('dropdown-1')" aria-controls={"dropdown-1"} label="Select me" icon_file="assets/icons.svg" />
        ...>     <:menu style="display: none" id="dropdown-1">
        ...>       <.ui_dropdown_option href="#" class="foo">
        ...>         Option 1
        ...>       </.ui_dropdown_option>
        ...>       <.ui_dropdown_option href="#">
        ...>         Option 2
        ...>       </.ui_dropdown_option>
        ...>       <li role="separator"></li>
        ...>       <.ui_dropdown_option href="#">
        ...>         Option 3
        ...>       </.ui_dropdown_option>
        ...>     </:menu>
        ...>   </.ui_dropdown>
        ...> </div>
        ...> """
        """
        <div style="min-height: 200px; width: 500px;">
          <div class="u-relative">
            <button type="button" aria-controls="dropdown-1" class="a-button a-button--ui" onclick=\"toggle(&#39;dropdown-1&#39;)\">
              <span class="a-button__label">
                Select me
              </span>
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m a-button__icon" focusable="false" height="16" width="16">
                <use xlink:href="assets/icons.svg#icon-caret-down">
                </use>
              </svg>
            </button>
            <ul class="a-dropdown u-overflow-y-auto a-list-reset a-dropdown--full-width u-margin-s-top" id="dropdown-1" style="display: none">
              <li>
                <a href="#" class="a-button a-button--menu foo">
                  Option 1
                </a>
              </li>
              <li>
                <a href="#" class="a-button a-button--menu">
                  Option 2
                </a>
              </li>
              <li role="separator">
              </li>
              <li>
                <a href="#" class="a-button a-button--menu">
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

  def ui_dropdown(assigns) do
    {button, button_extra} =
      assigns_from_single_slot(assigns, :button, exclude: [:label, :icon_file])

    button_extra =
      button_extra
      |> Keyword.put_new(:variant, :ui)
      |> maybe_put_icon(button[:label], button[:icon_file])

    {menu, menu_extra} = assigns_from_single_slot(assigns, :menu, exclude: [:class])

    class =
      classnames([
        "u-relative",
        assigns[:class],
        {"u-flex u-justify-end", variant?(:right, assigns[:variant])}
      ])

    extra = assigns_to_attributes(assigns, [:class, :menu, :button, :variant])

    assigns =
      assign(
        assigns,
        extra: extra,
        class: class,
        button_label: button[:label],
        button_extra: button_extra,
        menu_extra: menu_extra,
        menu_class: menu_class(assigns[:variant], menu[:class])
      )

    ~H"""
      <div class={@class} {@extra}>
        <.ui_button {@button_extra}>
          <%= if @button_label do %>
            <%= @button_label %>
          <% else %>
            <%= render_slot(@button) %>
          <% end %>
        </.ui_button>
        <ul class={@menu_class} {@menu_extra}>
          <%= render_slot(@menu) %>
        </ul>
      </div>
    """
  end

  @doc """
  Renders an option for usage inside of a dropdown menu.
  All attributes are passed down to the `BitstylesPhoenix.Component.Button.ui_button/1` component.
  """
  def ui_dropdown_option(assigns) do
    extra =
      assigns
      |> assigns_to_attributes()
      |> Keyword.put_new(:variant, "menu")

    assigns = assign(assigns, extra: extra)

    ~H"""
    <li>
      <.ui_button {@extra}><%= render_slot(@inner_block) %></.ui_button>
    </li>
    """
  end

  defp maybe_put_icon(button_extra, button_label, icon_file) when not is_nil(button_label) do
    icon =
      {"caret-down",
       [file: icon_file, size: "m", after: true] |> Enum.reject(&(elem(&1, 1) == nil))}

    Keyword.put_new(button_extra, :icon, icon)
  end

  defp maybe_put_icon(button_extra, _, _), do: button_extra

  @menu_classes ~w(a-dropdown u-overflow-y-auto a-list-reset)
  defp menu_class(variant, class) do
    classnames(@menu_classes ++ variant_classes(variant) ++ [margin(variant), class])
  end

  defp margin(variant) do
    if variant?(:top, variant), do: "u-margin-s-bottom", else: "u-margin-s-top"
  end

  defp variant_classes(nil), do: []

  defp variant_classes(variant) when is_binary(variant) or is_atom(variant),
    do: variant_classes([variant])

  defp variant_classes(variants) when is_list(variants),
    do: Enum.map(variants, &"a-dropdown--#{&1}")

  defp variant?(variant, list) when is_list(list), do: Enum.any?(list, &variant?(variant, &1))
  defp variant?(variant, variant) when is_atom(variant), do: true
  defp variant?(expected, actual) when is_binary(actual), do: to_string(expected) == actual
  defp variant?(_, _), do: false
end
