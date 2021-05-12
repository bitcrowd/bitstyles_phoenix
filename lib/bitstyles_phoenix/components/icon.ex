defmodule BitstylesPhoenix.Icon do
  import BitstylesPhoenix.Classnames
  import BitstylesPhoenix.Showcase
  alias BitstylesPhoenix.UseSVG

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
    """
        iex> safe_to_string ui_icon("inline-arrow")
        ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-inline-arrow"></svg>)
    """,
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
    """
        iex> safe_to_string ui_icon("hamburger", size: "s", external: "assets/icons.svg")
        ~s(<svg aria-hidden="true" class="a-icon a-icon--s" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="assets/icons.svg#icon-hamburger"></svg>)
    """
  )

  story(
    "An icon with extra options",
    """
        iex> safe_to_string ui_icon("bin", class: "foo bar", external: "assets/icons.svg")
        ~s(<svg aria-hidden="true" class="a-icon foo bar" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="assets/icons.svg#icon-bin"></svg>)
    """
  )

  def ui_icon(name, opts \\ []) do
    classname =
      classnames(["a-icon", {"a-icon--#{opts[:size]}", opts[:size] != nil}, opts[:class]])

    opts =
      opts
      |> put_defaults()
      |> Keyword.put(:class, classname)
      |> Keyword.merge(
        "aria-hidden": "true",
        focusable: "false"
      )
      |> Keyword.drop([:size])

    UseSVG.ui_svg("icon-#{name}", opts)
  end

  @default_size 16
  defp put_defaults(opts) do
    opts
    |> Keyword.put_new(:width, @default_size)
    |> Keyword.put_new(:height, @default_size)
  end
end
