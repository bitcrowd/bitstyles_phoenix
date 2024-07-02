defmodule BitstylesPhoenix.Component.Badge do
  use BitstylesPhoenix.Component
  alias BitstylesPhoenix.Bitstyles

  @moduledoc """
  The Badge component.
  """

  @doc ~s"""
  Render a badge to highlighted small texts, such as an item count or state indicator.

  ## Attributes

  - `variant` — Variant of the badge you want, from those available in the CSS classes e.g. `brand-1`, `danger`
  - `class` - Extra classes to pass to the badge. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `span` tag.

  See [bitstyles badge docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-badge--badge) for examples, and for the default variants available.
  """

  story(
    "Default badge",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_badge>
        ...>   published
        ...> </.ui_badge>
        ...> """
    ''',
    "6.0.0": '''
        """
        <span class="a-badge u-h6 u-font-medium" data-theme="grayscale">
          published
        </span>
        """
    ''',
    "5.0.1": '''
        """
        <span class="a-badge u-h6 u-font-medium a-badge--text">
          published
        </span>
        """
    ''',
    "4.3.0": '''
        """
        <span class="a-badge u-h6 u-font-medium a-badge--gray">
          published
        </span>
        """
    '''
  )

  story(
    "Badge variant brand-1",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_badge variant="brand-1">
        ...>   new
        ...> </.ui_badge>
        ...> """
    ''',
    "6.0.0": '''
        """
        <span class="a-badge u-h6 u-font-medium" data-theme="brand-1">
          new
        </span>
        """
    ''',
    "5.0.1": '''
        """
        <span class="a-badge u-h6 u-font-medium a-badge--brand-1">
          new
        </span>
        """
    '''
  )

  story(
    "Badge variant brand-2",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_badge variant="brand-2">
        ...>   recommended
        ...> </.ui_badge>
        ...> """
    ''',
    '''
        """
        <span class="a-badge u-h6 u-font-medium" data-theme="brand-2">
          recommended
        </span>
        """
    '''
  )

  story(
    "Badge variant danger",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_badge variant="danger">
        ...>   deleted
        ...> </.ui_badge>
        ...> """
    ''',
    '''
        """
        <span class="a-badge u-h6 u-font-medium" data-theme="danger">
          deleted
        </span>
        """
    '''
  )

  story(
    "Extra options and classes",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_badge class="extra-class" data-foo="bar">
        ...>   published
        ...> </.ui_badge>
        ...> """
    ''',
    '''
        """
        <span class="a-badge u-h6 u-font-medium extra-class" data-theme="grayscale" data-foo="bar">
          published
        </span>
        """
    '''
  )

  def ui_badge(assigns) do
    extra = assigns_to_attributes(assigns, [:class, :variant])

    {variant_class, extra} =
      if Bitstyles.version() >= "6.0.0" do
        theme = assigns[:variant] || "grayscale"
        {nil, Keyword.put_new(extra, :"data-theme", theme)}
      else
        variant = assigns[:variant] || "text"
        {"a-badge--#{variant}", extra}
      end

    class =
      classnames([
        "a-badge u-h6 u-font-medium",
        variant_class,
        assigns[:class]
      ])

    assigns = assign(assigns, class: class, extra: extra)
    ~H"<span class={@class} {@extra}><%= render_slot(@inner_block) %></span>"
  end
end
