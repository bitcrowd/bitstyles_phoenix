defmodule BitstylesPhoenix.Helper.Button do
  use Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Helper.Classnames
  import BitstylesPhoenix.Showcase

  @moduledoc """
  Helpers to create buttons and links.
  """

  @doc ~s"""
  Renders anchor or button elements that look like a button — using the `a-button` classes. It accepts similar options to
  `Phoenix.HTML.Link.button/2`, with the following additional notes/options:

  - `to` - if there’s a `to` parameter, you’ll get an anchor element, otherwise a button element. The option is also fowarded to `link_fn`
  - `link_fn` - Overrides the function used to generate the anchor element, when `to` is provided.
    By default, the anchor element will be generated with `Phoenix.HTML.Link.link/2`. 
    `link_fn` must be a function of arity 2, accepting a text and opts as argument.
    For example, one could pass Phoenix LiveView's [`live_redirect/2`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Helpers.html#live_redirect/2)
    or [`live_patch/2`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Helpers.html#live_patch/2).
  - `variant` - specifies which visual variant of button you want, from those available in the CSS classes e.g. `ui`, `danger`
  - `class` - Add custom classes in addition to the bitstyles button classes.

  All other parameters you pass are forwarded to the Phoenix link or submit helpers, if one of those is rendered.

  See the [bitstyles button docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-buttons-buttons--page) for available button variants.
  """

  story("Default submit button", '''
      iex> render ui_button("Save", type: "submit")
      """
      <button class="a-button" type="submit">
        Save
      </button>
      """
  ''')

  story("Default submit button with custom classes", '''
      iex> render ui_button("Save", type: "submit", class: "foo bar")
      """
      <button class="a-button foo bar" type="submit">
        Save
      </button>
      """
  ''')

  story("UI button", '''
      iex> render ui_button("Save", type: "submit", variant: :ui)
      """
      <button class="a-button a-button--ui" type="submit">
        Save
      </button>
      """
  ''')

  story("Dangerous button", '''
      iex> render ui_button("Save", type: "submit", variant: :danger)
      """
      <button class="a-button a-button--danger" type="submit">
        Save
      </button>
      """
  ''')

  story("Combine variants", '''
      iex> render ui_button("Save", type: "submit", variant: [:ui, :danger])
      """
      <button class="a-button a-button--ui a-button--danger" type="submit">
        Save
      </button>
      """
  ''')

  story("Pass along attributes to Phoenix helpers", '''
      iex> render ui_button("Show", to: "/admin/admin_accounts/id", data: [confirm: "Are you sure?"])
      """
      <a class="a-button" data-confirm="Are you sure?" href="/admin/admin_accounts/id">
        Show
      </a>
      """
  ''')

  story("Button with block content", '''
      iex> render(ui_button(to: "/foo") do
      ...>   "Save"
      ...> end)
      """
      <a class="a-button" href="/foo">
        Save
      </a>
      """
  ''')

  story("Button with a custom link function", '''
      iex> defmodule CustomLink do
      ...>   def link(text, opts), do: Phoenix.HTML.Tag.content_tag(:a, text, href: opts[:to], class: opts[:class])
      ...> end
      iex> render ui_button("Show", to: "/foo", link_fn: &CustomLink.link/2)
      """
      <a class="a-button" href=\"/foo\">
        Show
      </a>
      """
  ''')

  def ui_button(opts, do: contents) do
    ui_button(contents, opts)
  end

  def ui_button(label, opts) do
    opts = opts |> put_button_class()

    if opts[:to] do
      {link_fn, opts} = Keyword.pop(opts, :link_fn, &link/2)
      link_fn.(label, opts)
    else
      content_tag(:button, label, put_default_type(opts))
    end
  end

  defp put_button_class(opts) do
    opts
    |> Keyword.put(
      :class,
      classnames(["a-button"] ++ variant_classes(opts[:variant]) ++ [opts[:class]])
    )
    |> Keyword.drop([:variant])
  end

  defp variant_classes(nil), do: []

  defp variant_classes(variant) when is_binary(variant) or is_atom(variant),
    do: variant_classes([variant])

  defp variant_classes(variants) when is_list(variants),
    do: Enum.map(variants, &"a-button--#{&1}")

  defp put_default_type(opts) do
    Keyword.put_new(opts, :type, "button")
  end
end
