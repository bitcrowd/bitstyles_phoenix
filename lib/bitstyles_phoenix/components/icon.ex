defmodule BitstylesPhoenix.Components.Icon do
  import Phoenix.HTML.Tag, only: [content_tag: 3, tag: 2]
  import BitstylesPhoenix.Classnames

  @moduledoc """
  An SVG icon system, that expects the icons to be present on the page, rendered as SVG `<symbol>`s.
  """

  @doc ~S"""
  Renders an icon element.

  `opts[:name]` — The name of the icon to render. This must be present in the SVG that renders all the icons in the top of the body e.g. `_svgs.html.eex` as a `<symbol>` containing one filled path.

  ## Examples

      iex> safe_to_string ui_icon("right")
      ~s(<svg alt="" class="a-icon" role="presentation"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("right", size: "s")
      ~s(<svg alt="" class="a-icon a-icon--s" role="presentation"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("trashcan")
      ~s(<svg alt="" class="a-icon" role="presentation"><use xlink:href="#icon-trashcan"></svg>)

      iex> safe_to_string ui_icon("trashcan", class: "foo bar")
      ~s(<svg alt="" class="a-icon foo bar" role="presentation"><use xlink:href="#icon-trashcan"></svg>)
  """
  def ui_icon(name, opts \\ []) do
    classname =
      classnames(["a-icon", {"a-icon--#{opts[:size]}", opts[:size] != nil}, opts[:class]])

    content_tag(:svg, class: classname, alt: "", role: "presentation") do
      tag(:use, "xlink:href": "#icon-#{name}")
    end
  end
end
