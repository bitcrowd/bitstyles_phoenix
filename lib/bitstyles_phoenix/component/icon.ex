defmodule BitstylesPhoenix.Component.Icon do
  use BitstylesPhoenix.Component
  import BitstylesPhoenix.Component.UseSVG

  @moduledoc """
  An SVG icon system, that expects the icons to be present on the page, rendered as SVG `<symbol>`s.
  """

  @doc ~S"""
  Renders an icon element.

  Accepts the name of the icon to render. This must be present in the SVG that renders all the icons in the top of the body e.g. as a `<symbol>` containing one filled path.

  Options:
  `:size` - Specify the icon size to use. Available sizes are specified in CSS, and default to `s`, `m`, `l`, `xl`. If you do not specify a size, the icon will fit into a `1em` square.

  All other options are passed to the `Phoenix.HTML.Tag.content_tag/3` through `BitstylesPhoenix.UseSVG.ui_svg/2` of the outer `<svg>` element.

  See the [bitstyles icon docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-icon--icon) for examples of icon usage, and available icons in the bitstyles icon set.
  """

  story(
    "An icon (from inline svg)",
    '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_icon name="inline-arrow"/>
      ...> """
      """
      <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
        <use xlink:href="#icon-inline-arrow">
        </use>
      </svg>
      """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-inline-arrow" viewBox="0 0 100 100">
        <path d="M32.83,97.22a6.07,6.07,0,1,1-8.59-8.58L58.59,54.29a6.07,6.07,0,0,0,0-8.58L24.24,11.36a6.07,6.07,0,1,1,8.59-8.58L75.76,45.71a6.07,6.07,0,0,1,0,8.58Z" fill-rule="evenodd" />
      </symbol>
    </svg>
    """
  )

  story("An icon with a size", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_icon name="hamburger" file="assets/icons.svg" size="xl"/>
      ...> """
      """
      <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--xl" focusable="false" height="16" width="16">
        <use xlink:href="assets/icons.svg#icon-hamburger">
        </use>
      </svg>
      """
  ''')

  story("An icon with extra options", '''
    iex> assigns = %{}
    ...> render ~H"""
    ...> <.ui_icon name="bin" file="assets/icons.svg" class="foo bar"/>
    ...> """
    """
    <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon foo bar" focusable="false" height="16" width="16">
      <use xlink:href="assets/icons.svg#icon-bin">
      </use>
    </svg>
    """
  ''')

  def ui_icon(assigns) do
    icon = "icon-#{assigns.name}"

    class =
      classnames([
        "a-icon",
        {"a-icon--#{assigns[:size]}", assigns[:size] != nil},
        assigns[:class]
      ])

    extra =
      assigns
      |> assigns_to_attributes([:class, :name, :size])
      |> put_defaults

    assigns = assign(assigns, extra: extra, class: class, icon: icon)

    ~H"""
    <.ui_svg use={@icon} class={@class} aria-hidden="true" focusable="false" {@extra} />
    """
  end

  @default_size 16
  defp put_defaults(opts) do
    opts
    |> Keyword.put_new(:width, @default_size)
    |> Keyword.put_new(:height, @default_size)
  end
end
