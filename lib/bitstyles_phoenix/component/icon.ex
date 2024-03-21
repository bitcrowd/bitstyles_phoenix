defmodule BitstylesPhoenix.Component.Icon do
  use BitstylesPhoenix.Component
  import BitstylesPhoenix.Component.UseSVG

  @moduledoc """
  An SVG icon system, that expects the icons to be present on the page, rendered as SVG `<symbol>`s.
  """

  @doc ~S"""
  Renders an icon element.

  This uses `BitstylesPhoenix.Component.UseSVG` to render an icon either inlined in the page or
  referenced in an external SVG file. Icons are assumed to have an id prefixed with `icon-` followed
  by the name of the icon, which is used to reference the icon.

  ## Attributes

  - `name` *(required)* - The name of the icon. Assumes icons are prefixed with `icon-`.
  - `size` - Specify the icon size to use. Available sizes are specified in CSS, and default to `s`, `m`, `l`, `xl`. If you do not specify a size, the icon will fit into a `1em` square.
  - `file` - To be set if icons should be loaded from an external resource (see `BitstylesPhoenix.Component.UseSVG.ui_svg/1`).
    This can also be configured to a default `icon_file`, see `BitstylesPhoenix` for config options. With the configuration present, inline icons can still be rendered with `file={nil}`.
  - `class` - Extra classes to pass to the svg. See `BitstylesPhoenix.Helper.classnames/1` for usage.

  See the [bitstyles icon docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-icon) for examples of icon usage, and available icons in the [bitstyles icon set](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-icons).
  """

  story(
    "An icon (from inline svg)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon name="inline-arrow"/>
        ...> """
    ''',
    '''
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

  story(
    "An icon with a size",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon name="hamburger" file="/assets/icons.svg" size="xl"/>
        ...> """
    ''',
    '''
        """
        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--xl" focusable="false" height="16" width="16">
          <use xlink:href="/assets/icons.svg#icon-hamburger">
          </use>
        </svg>
        """
    '''
  )

  story(
    "An icon with extra options",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon name="bin" file="/assets/icons.svg" class="foo bar"/>
        ...> """
    ''',
    '''
        """
        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon foo bar" focusable="false" height="16" width="16">
          <use xlink:href="/assets/icons.svg#icon-bin">
          </use>
        </svg>
        """
    '''
  )

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
    |> put_icon_file(Application.get_env(:bitstyles_phoenix, :icon_file, :inline))
  end

  defp put_icon_file(opts, :inline), do: opts

  defp put_icon_file(opts, file) when is_binary(file) do
    Keyword.put_new(opts, :file, file)
  end

  defp put_icon_file(opts, {module, function, arguments}) do
    file = apply(module, function, arguments)
    put_icon_file(opts, file)
  end

  defp put_icon_file(opts, {module, function}) do
    file = apply(module, function)
    put_icon_file(opts, file)
  end
end
