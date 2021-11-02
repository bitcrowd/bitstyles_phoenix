defmodule BitstylesPhoenix.Component.Flash do
  use BitstylesPhoenix.Component

  @moduledoc """
  Component for building flash messages.
  """

  @doc ~s"""
  Render a flash message.

  Inform the user of a global or important event, such as may happen after a page reload.
  There are several variants, which use color, iconography, and html attributes to indicate severity.

  ## Attributes

  - `variant` - specifies which visual variant of flash you want, from those available in CSS.
    Defaults include: `brand-1`, `warning`, `info`, `danger`
  - `class` - Set CSS classes on the outer div.
  - `content_class` - Set CSS classes on the content div.
  - All other attributes are passed to the outer `div` tag.

  See [https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1)
  """

  story("Flash brand 1", '''
      iex> assigns = %{}
      iex> render(~H"""
      ...>   <.ui_flash variant="brand-1">
      ...>     Something you may be interested to hear
      ...>   </.ui_flash>
      ...> """)
      """
      <div aria-live="polite" class="u-padding-l-y a-flash a-flash--brand-1">
        <div class="a-content u-flex u-items-center u-font--medium">
          Something you may be interested to hear
        </div>
      </div>
      """
  ''')

  story("Flash success", '''
      iex> assigns = %{}
      iex> render(~H"""
      ...>   <.ui_flash variant="positive">
      ...>     Saved successfully
      ...>   </.ui_flash>
      ...> """)
      """
      <div aria-live="polite" class="u-padding-l-y a-flash a-flash--positive">
        <div class="a-content u-flex u-items-center u-font--medium">
          Saved successfully
        </div>
      </div>
      """
  ''')

  story("Flash warning", '''
      iex> assigns = %{}
      iex> render(~H"""
      ...>   <.ui_flash variant="warning">
      ...>     Saved with errors
      ...>   </.ui_flash>
      ...> """)
      """
      <div aria-live="polite" class="u-padding-l-y a-flash a-flash--warning">
        <div class="a-content u-flex u-items-center u-font--medium">
          Saved with errors
        </div>
      </div>
      """
  ''')

  story("Flash danger", '''
      iex> assigns = %{}
      iex> render(~H"""
      ...>   <.ui_flash variant="danger">
      ...>     Saving failed
      ...>   </.ui_flash>
      ...> """)
      """
      <div aria-live="polite" class="u-padding-l-y a-flash a-flash--danger">
        <div class="a-content u-flex u-items-center u-font--medium">
          Saving failed
        </div>
      </div>
      """
  ''')

  story("Custom attributes and classes", '''
      iex> assigns = %{}
      iex> render(~H"""
      ...>   <.ui_flash variant="brand-1" data-foo="bar" class="extra-class" content_class="extra-inner-class">
      ...>     Saving failed
      ...>   </.ui_flash>
      ...> """)
      """
      <div aria-live="polite" class="u-padding-l-y a-flash a-flash--brand-1 extra-class" data-foo="bar">
        <div class="a-content u-flex u-items-center u-font--medium extra-inner-class">
          Saving failed
        </div>
      </div>
      """
  ''')

  def ui_flash(assigns) do
    variant = assigns[:variant]

    class =
      classnames([
        "u-padding-l-y a-flash",
        {"a-flash--#{variant}", variant != nil},
        assigns[:class]
      ])

    content_class =
      classnames(["a-content u-flex u-items-center u-font--medium", assigns[:content_class]])

    extra = assigns_to_attributes(assigns, [:class, :content_class, :variant])
    assigns = assign(assigns, class: class, content_class: content_class, extra: extra)

    ~H"""
    <div aria-live="polite" class={@class} {@extra}>
      <div class={@content_class}>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
