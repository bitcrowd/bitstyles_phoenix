defmodule BitstylesPhoenix.Component.Tabs do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Button

  @moduledoc """
  The Tabs component.
  """

  @doc ~s"""
  Render a tab navigation header, optionnally with selected tabs.

  ## Attributes

  - `variant` — Variant of the badge you want, from those available in the CSS classes e.g. `brand-1`, `danger`
  - `class` - Extra classes to pass to the badge. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `active` - A value that represents the active tab. In order to be active, the tab has to have a `ref` attribute equal to this value.
  - All other attributes are passed to the `span` tag.

  ## Attributes - `tab` slot
  - `ref` - Sets the `active` attribute for the tab button if the parent `active` attribute matches it's value.
  - `button_opts` - Options passed down to `ui_tab_button/1` as attributes.
  - All other attributes are passed to `ui_tab`

  See [bitstyles badge docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-badge--badge) for examples, and for the default variants available.
  """

  story(
    "Tabs without active tab",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_tabs>
        ...>   <:tab>Foo</:tab>
        ...>   <:tab>Bar</:tab>
        ...>   <:tab>Baz</:tab>
        ...> </.ui_tabs>
        ...> """
        """
        <ul class="a-list-reset u-flex u-flex-wrap u-items-end a-button--tab-container u-margin-m-bottom" role="tablist">
          <li class="u-margin-s-right">
            <button class="a-button a-button--tab" type="button">
              Foo
            </button>
          </li>
          <li class="u-margin-s-right">
            <button class="a-button a-button--tab" type="button">
              Bar
            </button>
          </li>
          <li class="u-margin-s-right">
            <button class="a-button a-button--tab" type="button">
              Baz
            </button>
          </li>
        </ul>
        """
    ''',
    transparent: false
  )

  story(
    "Tabs with active attribute references (string)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_tabs active="foo">
        ...>   <:tab ref="foo">Foo</:tab>
        ...>   <:tab ref="bar">Bar</:tab>
        ...>   <:tab ref="baz">Baz</:tab>
        ...> </.ui_tabs>
        ...> """
        """
        <ul class="a-list-reset u-flex u-flex-wrap u-items-end a-button--tab-container u-margin-m-bottom" role="tablist">
          <li class="u-margin-s-right">
            <button aria-selected="true" class="a-button a-button--tab" type="button">
              Foo
            </button>
          </li>
          <li class="u-margin-s-right">
            <button aria-selected="false" class="a-button a-button--tab" type="button">
              Bar
            </button>
          </li>
          <li class="u-margin-s-right">
            <button aria-selected="false" class="a-button a-button--tab" type="button">
              Baz
            </button>
          </li>
        </ul>
        """
    ''',
    transparent: false
  )

  story(
    "Tabs with active attribute references (atom)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_tabs active={:foo}>
        ...>   <:tab ref={:foo}>Foo</:tab>
        ...>   <:tab ref={:bar}>Bar</:tab>
        ...>   <:tab ref={:baz} button_opts={[class: "extra"]}>Baz</:tab>
        ...> </.ui_tabs>
        ...> """
        """
        <ul class="a-list-reset u-flex u-flex-wrap u-items-end a-button--tab-container u-margin-m-bottom" role="tablist">
          <li class="u-margin-s-right">
            <button aria-selected="true" class="a-button a-button--tab" type="button">
              Foo
            </button>
          </li>
          <li class="u-margin-s-right">
            <button aria-selected="false" class="a-button a-button--tab" type="button">
              Bar
            </button>
          </li>
          <li class="u-margin-s-right">
            <button aria-selected="false" class="a-button a-button--tab extra" type="button">
              Baz
            </button>
          </li>
        </ul>
        """
    ''',
    transparent: false
  )

  def ui_tabs(assigns) do
    class =
      classnames([
        "a-list-reset u-flex u-flex-wrap u-items-end a-button--tab-container u-margin-m-bottom",
        assigns[:class]
      ])

    extra = assigns_to_attributes(assigns, [:class, :tab, :active])
    assigns = assign(assigns, class: class, extra: extra)

    ~H"""
    <ul class={@class} role="tablist" {@extra}>
      <%= for tab <- @tab do %>
        <li
          class={classnames(["u-margin-s-right", tab[:class]])}
          {assigns_to_attributes(tab, [:ref, :button_opts])}
        >
          <.ui_tab_button {button_options(tab, assigns[:active])}>
            <%= render_slot(tab) %>
          </.ui_tab_button>
        </li>
      <% end %>
    </ul>
    """
  end

  defp button_options(tab, active) do
    Map.get(tab, :button_opts, [])
    |> maybe_add_active(tab[:ref], active)
  end

  defp maybe_add_active(opts, _, nil), do: opts

  defp maybe_add_active(opts, ref, active_tab) do
    Keyword.put(opts, :active, ref == active_tab)
  end

  @doc """
  Rendering a tab button.

  - `active` - If set, sets `aria-selected` on the button (boolean).
  - All other attributes are passed to `BitstylesPhoenix.Component.Button.ui_button/1`.
  """
  def ui_tab_button(assigns) do
    extra = assigns_to_attributes(assigns, [:active])

    active =
      assigns
      |> Map.get(:active)
      |> case do
        false -> ["aria-selected": "false"]
        true -> ["aria-selected": "true"]
        _ -> []
      end

    assigns = assign(assigns, extra: Keyword.merge(extra, active))

    ~H"""
    <.ui_button {@extra} variant="tab">
      <%= render_slot(@inner_block) %>
    </.ui_button>
    """
  end
end
