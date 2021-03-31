defmodule BitstylesPhoenix.Components.Button do
  use Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Classnames

  @doc ~s"""
  Renders anchor or button elements that look like a button — using the `a-button` classes. It accepts similar parameters to
  `Phoenix.HTML.Link.button/2`, with the following additional notes:

  `opts[:to]` — if there’s a `to` parameter, you’ll get an anchor element, otherwise a button element.
  `opts[:variant]` — specifies which visual variant of button you want, from those available in the CSS classes e.g. `ui`, `danger`
  `opts[:e2e_classname]` — A classname that will be applied to the element for testing purposes, only on integration env

  All other parameters you pass are forwarded to the Phoenix link or submit helpers, if one of those is rendered.

  ## Examples

      iex> safe_to_string ui_button("Save", type: "submit")
      ~s(<button class="a-button" type="submit">Save</button>)

      iex> safe_to_string ui_button("Save", type: "submit", class: "foo bar")
      ~s(<button class="a-button foo bar" type="submit">Save</button>)

      iex> safe_to_string ui_button("Save", type: "submit", variant: :ui)
      ~s(<button class="a-button a-button--ui" type="submit">Save</button>)

      iex> safe_to_string ui_button("Save", type: "submit", variant: [:ui, :danger], class: "foo")
      ~s(<button class="a-button a-button--ui a-button--danger foo" type="submit">Save</button>)

      iex> safe_to_string ui_button("Click me", variant: "danger", type: "reset")
      ~s(<button class="a-button a-button--danger" type="reset">Click me</button>)

      iex> safe_to_string ui_button("Show", to: "/admin/admin_accounts/id", data: [confirm: "Are you sure?"])
      ~s(<a class="a-button" data-confirm="Are you sure?" href="/admin/admin_accounts/id">Show</a>)

      iex> safe_to_string ui_button("Click me", variant: "ui", type: "submit", data: [confirm: "Are you sure?"])
      ~s(<button class="a-button a-button--ui" data-confirm="Are you sure?" type="submit">Click me</button>)
  """
  def ui_button(opts, do: contents) do
    ui_button(contents, opts)
  end

  def ui_button(label, opts) do
    opts = opts |> put_default_button_class()

    if opts[:to] do
      link(label, opts)
    else
      opts = opts |> put_default_type()
      content_tag(:button, label, opts)
    end
  end

  defp put_default_button_class(opts) do
    opts
    |> Keyword.put(
      :class,
      classnames(
        [opts[:e2e_classname], "a-button"] ++ variant_classes(opts[:variant]) ++ [opts[:class]]
      )
    )
    |> Keyword.drop([:variant, :e2e_classname])
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
