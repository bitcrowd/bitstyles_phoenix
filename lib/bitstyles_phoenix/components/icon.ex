defmodule BitstylesPhoenix.Components.Icon do
  import Phoenix.HTML.Tag, only: [content_tag: 3, tag: 2]
  import BitstylesPhoenix.Classnames

  @moduledoc """
  An SVG icon system, that expects the icons to be present on the page, rendered as SVG `<symbol>`s.
  """

  @doc ~S"""
  Renders an icon element.

  `opts[:name]` — The name of the icon to render. This must be present in the SVG that renders all the icons in the top of the body e.g. `_svgs.html.eex` as a `<symbol>` containing one filled path.

  `opts[:size]` - Specify the icon size to use. Available sizes are specified in CSS, and default to `s`, `m`, `l`, `xl`. If you do not specify a size, the icon will fit into a `1em` square.

  See the [bitstyles icon docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-icon--icon) for examples of icon usage, and available icons in the bitstyles icon set.

  ## Examples

      iex> safe_to_string ui_icon("right")
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("right", size: "s")
      ~s(<svg aria-hidden="true" class="a-icon a-icon--s" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("trashcan")
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)

      iex> safe_to_string ui_icon("trashcan", width: "20", height: "20")
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="20" width="20" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)

      iex> safe_to_string ui_icon("trashcan", class: "foo bar")
      ~s(<svg aria-hidden="true" class="a-icon foo bar" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)
  """
  def ui_icon(name, opts \\ []) do
    classname =
      classnames(["a-icon", {"a-icon--#{opts[:size]}", opts[:size] != nil}, opts[:class]])

    opts =
      opts
      |> put_defaults()
      |> Keyword.put(:class, classname)
      |> Keyword.merge(
        "aria-hidden": "true",
        focusable: "false",
        xmlns: "http://www.w3.org/2000/svg"
      )
      |> Keyword.drop([:size])

    content_tag(:svg, opts) do
      tag(:use, "xlink:href": "#icon-#{name}")
    end
  end

  @default_size 16
  defp put_defaults(opts) do
    opts
    |> Keyword.put_new(:width, @default_size)
    |> Keyword.put_new(:height, @default_size)
  end
end
