defmodule BitstylesPhoenix.Component.Flash do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Content
  alias BitstylesPhoenix.Bitstyles

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
    Additionally you can pass `full` as a variant that will be set on the content class.
    Variants can be passed in as binary, atoms or as a list of atoms/binaries.
  - `class` - Set CSS classes on the outer div.
  - `content_class` - Set CSS classes on the content div.
  - All other attributes are passed to the outer `div` tag.

  See [https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1)
  """

  story(
    "Flash brand 1",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant="brand-1">
        ...>     Something you may be interested to hear
        ...>   </.ui_flash>
        ...> """)
    ''',
    [
      "6.0.0": '''
          """
          <div aria-live="polite" class="u-padding-l1-y a-flash" data-theme="brand-1">
            <div class="a-content u-flex u-items-center u-font-medium">
              Something you may be interested to hear
            </div>
          </div>
          """
      ''',
      "5.0.1": '''
          """
          <div aria-live="polite" class="u-padding-l-y a-flash a-flash--brand-1">
            <div class="a-content u-flex u-items-center u-font-medium">
              Something you may be interested to hear
            </div>
          </div>
          """
      '''
    ],
    width: "100%"
  )

  story(
    "Flash success",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant="positive">
        ...>     Saved successfully
        ...>   </.ui_flash>
        ...> """)
    ''',
    '''
        """
        <div aria-live="polite" class="u-padding-l1-y a-flash" data-theme="positive">
          <div class="a-content u-flex u-items-center u-font-medium">
            Saved successfully
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Flash warning",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant="warning">
        ...>     Saved with errors
        ...>   </.ui_flash>
        ...> """)
    ''',
    '''
        """
        <div aria-live="polite" class="u-padding-l1-y a-flash" data-theme="warning">
          <div class="a-content u-flex u-items-center u-font-medium">
            Saved with errors
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Flash danger",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant="danger">
        ...>     Saving failed
        ...>   </.ui_flash>
        ...> """)
    ''',
    '''
        """
        <div aria-live="polite" class="u-padding-l1-y a-flash" data-theme="danger">
          <div class="a-content u-flex u-items-center u-font-medium">
            Saving failed
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Flash with full content",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant={[:danger, :full]}>
        ...>     Saving failed
        ...>   </.ui_flash>
        ...> """)
    ''',
    '''
        """
        <div aria-live="polite" class="u-padding-l1-y a-flash" data-theme="danger">
          <div class="a-content a-content--full u-flex u-items-center u-font-medium">
            Saving failed
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  story(
    "Custom attributes and classes",
    '''
        iex> assigns = %{}
        iex> render(~H"""
        ...>   <.ui_flash variant="brand-1" data-foo="bar" class="extra-class" content_class="extra-inner-class">
        ...>     Saving failed
        ...>   </.ui_flash>
        ...> """)
    ''',
    '''
        """
        <div aria-live="polite" class="u-padding-l1-y a-flash extra-class" data-theme="brand-1" data-foo="bar">
          <div class="a-content u-flex u-items-center u-font-medium extra-inner-class">
            Saving failed
          </div>
        </div>
        """
    ''',
    width: "100%"
  )

  @content_variants [:full, "full"]

  def ui_flash(assigns) do
    variants = assigns[:variant] |> List.wrap()

    {content_variants, flash_variants} =
      Enum.split_with(variants, &Enum.member?(@content_variants, &1))

    extra = assigns_to_attributes(assigns, [:class, :content_class, :variant])

    {variant_class, extra} =
      if Bitstyles.Version.version() >= {6, 0, 0} do
        {nil, Keyword.put_new(extra, :"data-theme", Enum.at(flash_variants, 0))}
      else
        {flash_variants |> Enum.map_join(" ", &"a-flash--#{&1}"), extra}
      end

    class =
      classnames([
        "u-padding-l1-y a-flash",
        variant_class,
        assigns[:class]
      ])

    content_class = classnames(["u-flex u-items-center u-font-medium", assigns[:content_class]])

    assigns =
      assign(assigns,
        class: class,
        content_class: content_class,
        extra: extra,
        content_variants: content_variants
      )

    ~H"""
    <div aria-live="polite" class={@class} {@extra}>
      <.ui_content variant={@content_variants} class={@content_class}>
        <%= render_slot(@inner_block) %>
      </.ui_content>
    </div>
    """
  end
end
