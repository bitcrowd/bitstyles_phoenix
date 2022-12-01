defmodule BitstylesPhoenix.Component.Button do
  use BitstylesPhoenix.Component

  @moduledoc """
  The button component.
  """

  @link_attributes [:href, :navigate, :patch]

  import BitstylesPhoenix.Component.Icon

  @doc """
  Renders anchor or button elements that look like a button — using the `a-button` classes.
  - `href`, `navigate`, `patch` - if there’s one of these, you’ll get an anchor element, otherwise a button element. (See Phoenix.Component.link/1)
  - `variant` - specifies which visual variant of button you want, from those available in the CSS classes e.g. `ui`, `danger`
  - `class` - Extra classes to pass to the badge. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `icon` - An icon name as string or a tuple with `{icon_name, icon_opts}` which is passed to `BitstylesPhoenix.Component.Icon.ui_icon/1` as
    attributes. Additionally it is possible to pass `after: true` to the icon_opts, to make the icon appear after the button label instead of in
    front of it.

  All other attributes you pass are forwarded to [Phoenix.Component.link/1](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#link/1) or on the button tag, if one of those is rendered.

  See the [bitstyles button docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-buttons-buttons--page) for available button variants.


  See `BitstylesPhoenix.Helper.Button.ui_button/2` for more examples and options.
  """

  story("Default button", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button>
      ...>   Publish
      ...> </.ui_button>
      ...> """
      """
      <button type="button" class="a-button">
        Publish
      </button>
      """
  ''')

  story("Default link", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button href="/" variant="ui">
      ...>   Publish
      ...> </.ui_button>
      ...> """
      """
      <a href="/" class="a-button a-button--ui">
        Publish
      </a>
      """
  ''')

  story("Default disabled link renders disabled button instead", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button href="/" variant="ui" disabled>
      ...>   Publish
      ...> </.ui_button>
      ...> """
      """
      <button type="button" class="a-button a-button--ui" disabled="disabled">
        Publish
      </button>
      """
  ''')

  story("Default submit button", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button type="submit">
      ...>   Save
      ...> </.ui_button>
      ...> """
      """
      <button type="submit" class="a-button">
        Save
      </button>
      """
  ''')

  story("Default submit button with custom classes", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button type="submit" class="foo bar">
      ...>   Save
      ...> </.ui_button>
      ...> """
      """
      <button type="submit" class="a-button foo bar">
        Save
      </button>
      """
  ''')

  story("UI button", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button type="submit" variant={:ui}>
      ...>   Save
      ...> </.ui_button>
      ...> """
      """
      <button type="submit" class="a-button a-button--ui">
        Save
      </button>
      """
  ''')

  story("Dangerous button", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button type="submit" variant={:danger}>
      ...>   Save
      ...> </.ui_button>
      ...> """
      """
      <button type="submit" class="a-button a-button--danger">
        Save
      </button>
      """
  ''')

  story(
    "Button with an icon",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_button type="submit" icon="plus">
        ...>   Add
        ...> </.ui_button>
        ...> """
        """
        <button type="submit" class="a-button">
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
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_button href="/" icon={{"plus", after: true}}>
        ...>   Add
        ...> </.ui_button>
        ...> """
        """
        <a href="/" class="a-button">
          <span class="a-button__label">
            Add
          </span>
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-button__icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
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

  story("Pass along attributes to Phoenix helpers", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button href="/admin/admin_accounts/id" data-confirm="Are you sure?">
      ...>   Add
      ...> </.ui_button>
      ...> """
      """
      <a href="/admin/admin_accounts/id" class="a-button" data-confirm="Are you sure?">
        Add
      </a>
      """
  ''')

  story("Button with LiveView patch", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_button patch="/foo">
      ...>   Add
      ...> </.ui_button>
      ...> """
      """
      <a href="/foo" data-phx-link=\"patch\" data-phx-link-state=\"push\" class="a-button">
        Add
      </a>
      """
  ''')

  def ui_button(assigns) do
    extra = assigns_to_attributes(assigns, [:icon, :class, :variant])

    class = classnames(["a-button"] ++ variant_classes(assigns[:variant]) ++ [assigns[:class]])

    assigns =
      assigns
      |> assign(:extra, extra)
      |> assign(:class, class)

    ~H"""
    <.button_tag class={@class} {@extra}>
      <%= if assigns[:icon] do %>
        <.icon_with_label icon={@icon}>
          <%= render_slot(@inner_block) %>
        </.icon_with_label>
      <% else %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </.button_tag>
    """
  end

  defp button_tag(assigns) do
    assigns =
      if assigns[:to] do
        IO.warn("Attribute `to` is deprecated in ui_button/1! Change to `href`")

        assign(assigns, :href, assigns.to)
      else
        assigns
      end

    extra = assigns_to_attributes(assigns, [:type])

    assigns =
      assigns
      |> assign(
        :link,
        !assigns[:disabled] && Enum.any?(@link_attributes, &Map.has_key?(assigns, &1))
      )
      |> assign(:extra, extra)

    ~H"""
    <%= if @link do %>
      <.link {@extra}>
        <%= render_slot(@inner_block) %>
      </.link>
    <% else %>
      <button type={assigns[:type] || "button"} {Keyword.drop(@extra, [:to, :href, :navigate, :patch])}>
        <%= render_slot(@inner_block) %>
      </button>
    <% end %>
    """
  end

  defp variant_classes(nil), do: []

  defp variant_classes(variant) when is_binary(variant) or is_atom(variant),
    do: variant_classes([variant])

  defp variant_classes(variants) when is_list(variants),
    do: Enum.map(variants, &"a-button--#{&1}")

  defp icon_with_label(%{icon: icon} = assigns) when is_binary(icon) do
    assigns
    |> assign(:icon, {icon, []})
    |> icon_with_label()
  end

  defp icon_with_label(%{icon: {icon, opts}} = assigns) do
    {icon_after, opts} = Keyword.pop(opts, :after)
    icon_opts = Keyword.merge(opts, name: icon, class: "a-button__icon")
    assigns = assigns |> assign(:icon_opts, icon_opts) |> assign(:icon_after, icon_after)

    ~H"""
    <%= unless @icon_after do %>
      <.ui_icon {@icon_opts} />
    <% end %>
    <span class={classnames("a-button__label")}><%= render_slot(@inner_block) %></span>
    <%= if @icon_after do %>
      <.ui_icon {@icon_opts} />
    <% end %>
    """
  end

  @doc """
  An icon button with sr text and title. Accepts an icon name and a label.

  The icon can be either provided as icon name string, or as tuple with `{name, icon_opts}` where the name is the
  icon name and icon options that are passed as attributes to `BitstylesPhoenix.Component.Icon.ui_icon`.

  ## Attributes
  - `icon` - An icon name as string or a tuple of {name, icon_opts} to be passed on.
  - `label` - A screen reader label for the button.
  - `reversed` - Icon reversed style (see examples)
  - All other attributes are passed in as attributes to `BitstylesPhoenix.Component.Button.ui_button/1`.
  """

  story(
    "Icon button",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon_button icon="plus" label="Add" href="#"/>
        ...> """
        """
        <a href="#" class="a-button a-button--icon" title="Add">
          <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon" focusable="false" height="16" width="16">
            <use xlink:href="#icon-plus">
            </use>
          </svg>
          <span class="u-sr-only">
            Add
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

  story("Icon button with some options", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_icon_button icon={{"bin", file: "assets/icons.svg", size: "xl"}} label="Delete" class="foo" />
      ...> """
      """
      <button type="button" class="a-button a-button--icon foo" title="Delete">
        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="a-icon a-icon--xl" focusable="false" height="16" width="16">
          <use xlink:href="assets/icons.svg#icon-bin">
          </use>
        </svg>
        <span class="u-sr-only">
          Delete
        </span>
      </button>
      """
  ''')

  story(
    "Icon button reversed",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_icon_button icon="plus" label="Show" href="#" reversed />
        ...> """
        """
        <a href="#" class="a-button a-button--icon a-button--icon-reversed" title="Show">
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

  def ui_icon_button(assigns) do
    extra = assigns_to_attributes(assigns, [:icon, :label, :reversed, :variant, :title])

    {icon, icon_opts} =
      case assigns.icon do
        {icon, icon_opts} -> {icon, icon_opts}
        icon -> {icon, []}
      end

    icon_reversed = if assigns[:reversed], do: ["icon-reversed"], else: []
    variant = [:icon] ++ icon_reversed ++ List.wrap(assigns[:variant])
    assigns = assign(assigns, extra: extra, icon: icon, icon_opts: icon_opts, variant: variant)

    ~H"""
    <.ui_button variant={@variant} title={assigns[:title] || @label} {@extra}>
      <.ui_icon name={@icon} {@icon_opts}/>
      <span class={classnames("u-sr-only")}><%= @label %></span>
    </.ui_button>
    """
  end
end
