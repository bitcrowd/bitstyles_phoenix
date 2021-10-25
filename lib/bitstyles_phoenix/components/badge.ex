defmodule BitstylesPhoenix.Badge do
  use BitstylesPhoenix.Component

  @moduledoc """
  The Badge component.
  """

  @doc ~s"""
  Renders an inline badge UI component — this could be any small text that you want highlighted, such as an item count or state indicator.

  - `variant` — specifies which visual variant of the badge you want, from those available in the CSS classes e.g. `brand-1`, `danger`
  - `class` - extra classes to set on the badge

  See [bitstyles badge docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-badge--badge) for examples, and for the default variants available.
  """

  story("Default badge", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_badge>
      ...>   published
      ...> </.ui_badge>
      ...> """
      """
      <span class="a-badge u-h6 u-font--medium a-badge--gray">
        published
      </span>
      """
  ''')

  story("Badge variant brand-1", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_badge variant="brand-1">
      ...>   new
      ...> </.ui_badge>
      ...> """
      """
      <span class="a-badge u-h6 u-font--medium a-badge--brand-1">
        new
      </span>
      """
  ''')

  story("Badge variant brand-2", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_badge variant="brand-2">
      ...>   recommended
      ...> </.ui_badge>
      ...> """
      """
      <span class="a-badge u-h6 u-font--medium a-badge--brand-2">
        recommended
      </span>
      """
  ''')

  story("Badge variant danger", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_badge variant="danger">
      ...>   deleted
      ...> </.ui_badge>
      ...> """
      """
      <span class="a-badge u-h6 u-font--medium a-badge--danger">
        deleted
      </span>
      """
  ''')

  story("Extra options and classes", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_badge class="extra-class" data-foo="bar">
      ...>   published
      ...> </.ui_badge>
      ...> """
      """
      <span class="a-badge u-h6 u-font--medium a-badge--gray extra-class" data-foo="bar">
        published
      </span>
      """
  ''')

  def ui_badge(assigns) do
    variant = assigns[:variant] || "gray"

    class =
      classnames([
        "a-badge u-h6 u-font--medium a-badge--#{variant}",
        assigns[:class]
      ])

    extra = assigns_to_attributes(assigns, [:class, :variant])
    assigns = assign(assigns, class: class, extra: extra)
    ~H"<span class={@class} {@extra}><%= render_slot(@inner_block) %></span>"
  end
end
