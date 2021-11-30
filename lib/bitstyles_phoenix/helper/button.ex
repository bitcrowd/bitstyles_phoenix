defmodule BitstylesPhoenix.Helper.Button do
  use Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import Phoenix.LiveView.Helpers
  import BitstylesPhoenix.Helper.Classnames
  import BitstylesPhoenix.Component.Icon
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
  - `class` - Extra classes to pass to the badge. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `icon` - An icon name as string or a tuple with `{icon_name, icon_opts}` which is passed to `BitstylesPhoenix.Component.Icon.ui_icon/1` as
    attributes. Additionally it is possible to pass `after: true` to the icon_opts, to make the icon appear after the button label instead of in
    front of it.

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

  story(
    "Button with an icon",
    '''
        iex> render ui_button("Add", type: "submit", icon: "plus")
        """
        <button class="a-button" type="submit">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-button__icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
          <span class="a-button__label">
            Add
          </span>
        </button>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-plus" viewBox="0 0 100 100">
        <path d="M54.57,87.43V54.57H87.43a4.57,4.57,0,0,0,0-9.14H54.57V12.57a4.57,4.57,0,1,0-9.14,0V45.43H12.57a4.57,4.57,0,0,0,0,9.14H45.43V87.43a4.57,4.57,0,0,0,9.14,0Z"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Button with an icon after",
    '''
        iex> render ui_button("Add", type: "submit", icon: {"plus", after: true})
        """
        <button class="a-button" type="submit">
          <span class="a-button__label">
            Add
          </span>
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-button__icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
        </button>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-plus" viewBox="0 0 100 100">
        <path d="M54.57,87.43V54.57H87.43a4.57,4.57,0,0,0,0-9.14H54.57V12.57a4.57,4.57,0,1,0-9.14,0V45.43H12.57a4.57,4.57,0,0,0,0,9.14H45.43V87.43a4.57,4.57,0,0,0,9.14,0Z"/>
      </symbol>
    </svg>
    """
  )

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
      <a class="a-button" href="/foo">
        Show
      </a>
      """
  ''')

  def ui_button(opts, do: contents) do
    ui_button(contents, opts)
  end

  def ui_button(label, opts) do
    opts = opts |> put_button_class()

    cond do
      Keyword.has_key?(opts, :icon) ->
        {icon, opts} = Keyword.pop(opts, :icon)
        ui_button(icon_with_label(icon, label), opts)

      Keyword.has_key?(opts, :to) ->
        {link_fn, opts} = Keyword.pop(opts, :link_fn, &link/2)
        link_fn.(label, opts)

      true ->
        content_tag(:button, label, put_default_type(opts))
    end
  end

  defp icon_with_label(icon, label) when is_binary(icon) do
    icon_with_label({icon, []}, label)
  end

  defp icon_with_label({icon, opts}, label) when is_binary(icon) do
    {icon_after, opts} = Keyword.pop(opts, :after)
    icon_opts = Keyword.merge(opts, name: icon, class: "a-button__icon")
    label = content_tag(:span, label, class: "a-button__label")
    assigns = %{label: label, icon_opts: icon_opts}

    if icon_after do
      ~H"""
      <%= @label %><.ui_icon {@icon_opts} />
      """
    else
      ~H"""
      <.ui_icon {@icon_opts} /><%= @label %>
      """
    end
  end

  @doc """
  An icon button with sr text and title. Accepts an icon name, a label and the following options:

  The icon can be either provided as icon name string, or as tuple with `{name, icon_opts}` where the name is the
  icon name and icon options that are passed as attributes to `BitstylesPhoenix.Component.Icon.ui_icon`.

  ## Options:

  - `reversed` - Icon reversed style (see examples)
  - All other options are passed to `ui_button/2`
  """

  story(
    "Icon button",
    '''
        iex> render ui_icon_button("plus", "Show", to: "#")
        """
        <a class="a-button a-button--icon" href="#" title="Show">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
          <span class="u-sr-only">
            Show
          </span>
        </a>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-plus" viewBox="0 0 100 100">
        <path d="M54.57,87.43V54.57H87.43a4.57,4.57,0,0,0,0-9.14H54.57V12.57a4.57,4.57,0,1,0-9.14,0V45.43H12.57a4.57,4.57,0,0,0,0,9.14H45.43V87.43a4.57,4.57,0,0,0,9.14,0Z"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Icon button reversed",
    '''
        iex> render ui_icon_button("plus", "Show", to: "#", reversed: true)
        """
        <a class="a-button a-button--icon a-button--icon-reversed" href="#" title="Show">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
          <span class="u-sr-only">
            Show
          </span>
        </a>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="icon-plus" viewBox="0 0 100 100">
        <path d="M54.57,87.43V54.57H87.43a4.57,4.57,0,0,0,0-9.14H54.57V12.57a4.57,4.57,0,1,0-9.14,0V45.43H12.57a4.57,4.57,0,0,0,0,9.14H45.43V87.43a4.57,4.57,0,0,0,9.14,0Z"/>
      </symbol>
    </svg>
    """
  )

  story(
    "Icon button with opts",
    '''
        iex> render ui_icon_button({"bin", file: "assets/icons.svg", size: "xl"}, "Show", to: "#", class: "foo")
        """
        <a class="a-button a-button--icon foo" href="#" title="Show">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--xl" focusable="false" height="16" width="16">
            <use xlink:href="assets/icons.svg#icon-bin">
            </use>
          </svg>
          <span class="u-sr-only">
            Show
          </span>
        </a>
        """
    '''
  )

  def ui_icon_button(icon, label, opts \\ [])

  def ui_icon_button(icon, label, opts) when is_binary(icon) do
    ui_icon_button({icon, []}, label, opts)
  end

  def ui_icon_button({icon, icon_opts}, label, opts) when is_binary(label) and is_binary(icon) do
    {reversed, opts} = Keyword.pop(opts, :reversed)
    {variant, opts} = Keyword.pop(opts, :variant)
    icon_variant = if reversed, do: [:icon, :"icon-reversed"], else: [:icon]
    variant = icon_variant ++ List.wrap(variant)
    opts = opts |> Keyword.merge(variant: variant) |> Keyword.put_new(:title, label)
    assigns = %{icon: icon, label: label, icon_opts: icon_opts}

    ui_button(opts) do
      ~H"""
        <.ui_icon name={@icon} {icon_opts}/>
        <span class="u-sr-only"><%= @label %></span>
      """
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
