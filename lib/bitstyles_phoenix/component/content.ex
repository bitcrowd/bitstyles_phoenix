defmodule BitstylesPhoenix.Component.Content do
  use BitstylesPhoenix.Component

  @moduledoc """
  The Content component.
  """

  @doc ~s"""
  Renders a content div, to add some spacing to the sides of your content.

  ## Attributes

  - `variant` — Variant of the content you want, from those available in the CSS classes e.g. `full`
  - `class` - Extra classes to pass to the content. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `div` tag.

  See [bitstyles content docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-content--content) for examples, and for the default variants available.
  """

  story(
    "Default content",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_content>
        ...>   Content
        ...> </.ui_content>
        ...> """
    ''',
    '''
        """
        <div class="a-content">
          Content
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Full content",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_content variant="full">
        ...>   Full Content
        ...> </.ui_content>
        ...> """
    ''',
    '''
        """
        <div class="a-content a-content--full">
          Full Content
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Extra classes and attributes",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_content variant="full" class="u-h2" data-foo="bar">
        ...>   Content with extra
        ...> </.ui_content>
        ...> """
    ''',
    '''
        """
        <div class="a-content a-content--full u-h2" data-foo="bar">
          Content with extra
        </div>
        """
    ''',
    width: "100%"
  )

  def ui_content(assigns) do
    variant_classes = assigns[:variant] |> List.wrap() |> Enum.map_join(" ", &"a-content--#{&1}")

    class = classnames(["a-content", variant_classes, assigns[:class]])

    extra = assigns_to_attributes(assigns, [:class, :variant])
    assigns = assign(assigns, class: class, extra: extra)

    ~H"""
    <div class={@class} {@extra}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
