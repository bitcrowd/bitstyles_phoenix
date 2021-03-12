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

    iex> doctest_ui_component ui_icon("right")
    ~s(<svg alt="" class="a-icon" role="presentation"><use xlink:href="#icon-right"></svg>)

    iex> doctest_ui_component ui_icon("right", size: "s")
    ~s(<svg alt="" class="a-icon a-icon--s" role="presentation"><use xlink:href="#icon-right"></svg>)

    iex> doctest_ui_component ui_icon("trashcan")
    ~s(<svg alt="" class="a-icon" role="presentation"><use xlink:href="#icon-trashcan"></svg>)
  """
  def ui_icon(name, opts \\ []) do
    classname = classnames(["a-icon", {"a-icon--#{opts[:size]}", opts[:size] != nil}])

    content_tag(:svg, class: classname, alt: "", role: "presentation") do
      tag(:use, "xlink:href": "#icon-#{name}")
    end
  end
end
