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

  ## Examples

      iex> safe_to_string ui_icon("right")
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("right", size: "s")
      ~s(<svg aria-hidden="true" class="a-icon a-icon--s" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-right"></svg>)

      iex> safe_to_string ui_icon("trashcan")
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)

      iex> safe_to_string ui_icon("trashcan", width: 20)
      ~s(<svg aria-hidden="true" class="a-icon" focusable="false" height="20" width="20" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)

      iex> safe_to_string ui_icon("trashcan", class: "foo bar")
      ~s(<svg aria-hidden="true" class="a-icon foo bar" focusable="false" height="16" width="16" xmlns="http://www.w3.org/2000/svg"><use xlink:href="#icon-trashcan"></svg>)
  """
  def ui_icon(name, opts \\ []) do
    classname =
      classnames(["a-icon", {"a-icon--#{opts[:size]}", opts[:size] != nil}, opts[:class]])
    opts = opts |> put_default_width()

    content_tag(:svg, class: classname, "aria-hidden": "true", focusable: "false", xmlns: "http://www.w3.org/2000/svg", width: opts[:width], height: opts[:width]) do
      tag(:use, "xlink:href": "#icon-#{name}")
    end
  end

  defp put_default_width(opts) do
    if is_integer(opts[:width]) do
      opts
    else
      opts |> Keyword.put_new(:width, 16)
    end
  end
end
