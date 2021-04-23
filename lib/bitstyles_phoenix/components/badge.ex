defmodule BitstylesPhoenix.Badge do
  use Phoenix.HTML
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Classnames
  import BitstylesPhoenix.Showcase

  @moduledoc """
  The Badge component.
  """

  @doc ~s"""
  Renders an inline badge UI component — this could be any small text that you want highlighted, such as an item count or state indicator.

  `opts[:to]` — if there’s a `to` parameter, you’ll get an anchor element, otherwise a button element.
  `opts[:variant]` — specifies which visual variant of button you want, from those available in the CSS classes e.g. `ui`, `danger`
  `opts[:e2e_classname]` — A classname that will be applied to the element for testing purposes, only on integration env

  See [bitstyles badge docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-badge--badge) for examples, and for the default variants available.
  """

  story("Default badge", """
      iex> safe_to_string ui_badge("published")
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--gray">published</span>)
  """)

  story("Default badge with options", """
      iex> safe_to_string ui_badge("published", class: "foo bar")
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--gray foo bar">published</span>)
  """)

  story("Brand 1 badge", """
      iex> safe_to_string ui_badge("published", variant: "brand-1")
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--brand-1">published</span>)
  """)

  story("Brand 2 badge", """
      iex> safe_to_string ui_badge("published", variant: "brand-2")
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--brand-2">published</span>)
  """)

  story("Dangerous badge", """
      iex> safe_to_string ui_badge("edited", variant: "danger")
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--danger">edited</span>)
  """)

  story("Default badge as a block", """
      iex> safe_to_string(ui_badge do
      ...>   "published"
      ...> end)
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--gray">published</span>)
  """)

  story("Badge as a block", """
      iex> safe_to_string(ui_badge(variant: "danger") do
      ...>   "published"
      ...> end)
      ~s(<span class="a-badge u-h6 u-font--medium a-badge--danger">published</span>)
  """)

  def ui_badge(do: contents), do: ui_badge(contents, [])
  def ui_badge(label), do: ui_badge(label, [])
  def ui_badge(opts, do: contents), do: ui_badge(contents, opts)

  def ui_badge(label, opts) do
    opts = opts |> put_default_variant() |> put_default_badge_class()

    content_tag(:span, label, opts)
  end

  defp put_default_badge_class(opts) do
    opts
    |> Keyword.put(
      :class,
      classnames(
        [opts[:e2e_classname], "a-badge u-h6 u-font--medium"] ++
          variant_classes(opts[:variant]) ++ [opts[:class]]
      )
    )
    |> Keyword.delete(:variant)
  end

  defp put_default_variant(opts) do
    Keyword.put_new(opts, :variant, "gray")
  end

  defp variant_classes(variant) when is_binary(variant) or is_atom(variant),
    do: variant_classes([variant])

  defp variant_classes(variants) when is_list(variants),
    do: Enum.map(variants, &"a-badge--#{&1}")
end
