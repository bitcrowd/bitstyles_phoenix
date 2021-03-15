defmodule BitstylesPhoenix.Components.Button do
  use Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Classnames

  @moduledoc """
  Button and button-like UI components
  """

  @doc ~S"""
  Renders anchor or button elements that look like a button — using the `a-button` classes. It accepts similar parameters to
  `Phoenix.HTML.Link.button/2`, with the following additional notes:

  `opts[:to]` — if there’s a `to` parameter, you’ll get an anchor element, otherwise a button element.
  `opts[:variant]` — specifies which visual variant of button you want, from those available in the CSS classes e.g. `primary`, `danger`
  `opts[:e2e_classname]` — A classname that will be applied to the element for testing purposes, only on integration env

  All other parameters you pass are forwarded to the Phoenix link or submit helpers, if one of those is rendered.

  ## Examples

      iex> safe_to_string ui_button("Save", type: "submit")
      ~s(<button class="a-button" type="submit">Save</button>)

      iex> safe_to_string ui_button("Save", type: "submit", variant: "primary")
      ~s(<button class="a-button a-button--primary" type="submit">Save</button>)

      iex> safe_to_string ui_button("Click me", variant: "clear", type: "reset")
      ~s(<button class="a-button a-button--clear" type="reset">Click me</button>)

      iex> safe_to_string ui_button("Show", to: "/admin/admin_accounts/id", data: [confirm: "Are you sure?"])
      ~s(<a class="a-button" data-confirm="Are you sure?" href="/admin/admin_accounts/id">Show</a>)

      iex> safe_to_string ui_button("Click me", variant: "clear", type: "submit", data: [confirm: "Are you sure?"])
      ~s(<button class="a-button a-button--clear" data-confirm="Are you sure?" type="submit">Click me</button>)
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
      classnames([
        opts[:e2e_classname],
        "a-button",
        {"a-button--#{opts[:variant]}", opts[:variant] != nil}
      ])
    )
    |> Keyword.drop([:variant, :e2e_classname])
  end

  defp put_default_type(opts) do
    Keyword.put_new(opts, :type, "button")
  end
end
