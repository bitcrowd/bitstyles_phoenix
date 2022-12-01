defmodule BitstylesPhoenix.Component.Breadcrumbs do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Icon

  @moduledoc """
  The Breadcrumbs component.
  """

  @doc ~s"""
  Render breadcrumbs (usually links) to reflect the page structure.

  ## Attributes

  - `icon_file` - The external SVG file with icons to be passed on to
    `BitstylesPhoenix.Component.Icon.ui_icon/1` for the breadcrumb icon.
    Only needed if SVG icons are not provided inline on the HTML.
  - `class` - Extra classes to pass to the `ul` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `nav` tag.

  ## Attributes - `item` slot

  - `class` - Extra classes to pass to the `li` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `li` tag.

  See [bitstyles breadcrumbs docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-navigation-breadcrumbs--breadcrumbs) for examples.
  """

  story(
    "Breadcrumbs",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_breadcrumbs>
        ...>   <:item>Foo</:item>
        ...>   <:item>Bar</:item>
        ...>   <:item>Baz</:item>
        ...> </.ui_breadcrumbs>
        ...> """
        """
        <nav aria-label="breadcrumbs">
          <ol class="u-h6 a-list-reset u-flex u-flex-wrap u-items-center">
            <li class="u-margin-xs-right u-flex u-items-center">
              Foo
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Bar
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Baz
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
          </ol>
        </nav>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-right" viewBox="0 0 100 100">
        <path d="M34.23,93.36a5.57,5.57,0,0,1-7.89-7.87L61.91,50.08,26.34,14.51a5.57,5.57,0,0,1,7.89-7.87L73.66,46.06a5.58,5.58,0,0,1,0,7.88Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Breadcrumbs via array",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_breadcrumbs items={["Foo", "Bar", "Baz"]} />
        ...> """
        """
        <nav aria-label="breadcrumbs">
          <ol class="u-h6 a-list-reset u-flex u-flex-wrap u-items-center">
            <li class="u-margin-xs-right u-flex u-items-center">
              Foo
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Bar
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Baz
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
          </ol>
        </nav>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-right" viewBox="0 0 100 100">
        <path d="M34.23,93.36a5.57,5.57,0,0,1-7.89-7.87L61.91,50.08,26.34,14.51a5.57,5.57,0,0,1,7.89-7.87L73.66,46.06a5.58,5.58,0,0,1,0,7.88Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Breadcrumbs with custom classes and properties",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_breadcrumbs class="u-fg-warning" data-foo="bar">
        ...>   <:item class="u-fg-brand-2" data-baz="foo">Foo</:item>
        ...>   <:item>Bar</:item>
        ...>   <:item>Baz</:item>
        ...> </.ui_breadcrumbs>
        ...> """
        """
        <nav aria-label="breadcrumbs" data-foo="bar">
          <ol class="u-h6 a-list-reset u-flex u-flex-wrap u-items-center u-fg-warning">
            <li class="u-margin-xs-right u-flex u-items-center u-fg-brand-2" data-baz="foo">
              Foo
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Bar
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
            <li class="u-margin-xs-right u-flex u-items-center">
              Baz
              <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--m u-fg-gray-30 u-margin-xs-left" focusable="false" height="16" width="16">
                <use xlink:href="#icon-caret-right">
                </use>
              </svg>
            </li>
          </ol>
        </nav>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-caret-right" viewBox="0 0 100 100">
        <path d="M34.23,93.36a5.57,5.57,0,0,1-7.89-7.87L61.91,50.08,26.34,14.51a5.57,5.57,0,0,1,7.89-7.87L73.66,46.06a5.58,5.58,0,0,1,0,7.88Z" fill-rule="evenodd"/>
      </symbol>
    </svg>
    """
  )

  def ui_breadcrumbs(assigns) do
    extra = assigns_to_attributes(assigns, [:icon_file, :item, :class, :items])
    icon_extra = Map.take(assigns, [:icon_file]) |> Map.to_list()
    assigns = assign(assigns, extra: extra, icon_extra: icon_extra)

    ~H"""
      <nav aria-label="breadcrumbs" {@extra}>
        <ol class={classnames(["u-h6 a-list-reset u-flex u-flex-wrap u-items-center", assigns[:class]])}>
          <%= for item <- (assigns[:item] || assigns[:items]) do %>
            <li
              class={classnames(["u-margin-xs-right u-flex u-items-center", assigns[:item] && item[:class]])}
              {assigns[:item] && assigns_to_attributes(item, [:class]) || []}
            >
              <%= if assigns[:item], do: render_slot(item), else: item %>
              <.ui_icon name="caret-right" size="m" class="u-fg-gray-30 u-margin-xs-left" {@icon_extra} />
            </li>
          <% end %>
        </ol>
      </nav>
    """
  end
end
