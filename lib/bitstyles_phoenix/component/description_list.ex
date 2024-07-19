defmodule BitstylesPhoenix.Component.DescriptionList do
  use BitstylesPhoenix.Component
  alias BitstylesPhoenix.Bitstyles

  @moduledoc """
  The description list components.
  """

  story(
    "With items (short-cut form)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dl>
        ...>   <.ui_dl_item label="Length" value="8" />
        ...>   <.ui_dl_item label="Inserted at">2007-01-02</.ui_dl_item>
        ...> </.ui_dl>
        ...> """
    ''',
    [
      "5.0.1": '''
          """
          <dl class="a-dl">
            <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-l">
              <dt class="u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s">
                Length
              </dt>
              <dd class="u-col-span-2">
                8
              </dd>
            </div>
            <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-l">
              <dt class="u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s">
                Inserted at
              </dt>
              <dd class="u-col-span-2">
                2007-01-02
              </dd>
            </div>
          </dl>
          """
      ''',
      "4.3.0": '''
          """
          <dl class="a-dl">
            <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-m">
              <dt class="u-font-medium u-h6 u-fg-gray-50 u-margin-xs-bottom@s">
                Length
              </dt>
              <dd class="u-col-span-2">
                8
              </dd>
            </div>
            <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-m">
              <dt class="u-font-medium u-h6 u-fg-gray-50 u-margin-xs-bottom@s">
                Inserted at
              </dt>
              <dd class="u-col-span-2">
                2007-01-02
              </dd>
            </div>
          </dl>
          """
      '''
    ],
    module: true,
    width: "100%"
  )

  story(
    "With items (short-cut and long form) and extra attributes",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dl class="extra" data-foo="baz">
        ...>   <.ui_dl_item label="Length" class="u-fg-brand-2">8</.ui_dl_item>
        ...>   <.ui_dl_item>
        ...>     <.ui_dt class="u-fg-brand-1" data-foo="bar">Some</.ui_dt>
        ...>     <.ui_dd class="u-fg-brand-1" data-foo="bar">Tag</.ui_dd>
        ...>   </.ui_dl_item>
        ...>   <.ui_dl_item>
        ...>     <.ui_dt><pre>Tag</pre></.ui_dt>
        ...>     <.ui_dd>Value</.ui_dd>
        ...>   </.ui_dl_item>
        ...> </.ui_dl>
        ...> """
    ''',
    '''
        """
        <dl class="a-dl extra" data-foo="baz">
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-l u-fg-brand-2">
            <dt class="u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s">
              Length
            </dt>
            <dd class="u-col-span-2">
              8
            </dd>
          </div>
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-l">
            <dt class="u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s u-fg-brand-1" data-foo="bar">
              Some
            </dt>
            <dd class="u-col-span-2 u-fg-brand-1" data-foo="bar">
              Tag
            </dd>
          </div>
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-gap-l">
            <dt class="u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s">
              <pre>
                Tag
              </pre>
            </dt>
            <dd class="u-col-span-2">
              Value
            </dd>
          </div>
        </dl>
        """
    ''',
    module: true,
    width: "100%"
  )

  @doc ~s"""
  Render a description list.

  ## Attributes

  - `class` - Extra classes to pass to the `dl` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `dl` tag.

  See [bitstyles description list docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-description-list--description-list) for examples.
  """

  def ui_dl(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    assigns = assign(assigns, extra: extra)

    ~H"""
      <dl class={classnames(["a-dl", assigns[:class]])} {@extra}>
        <%= render_slot(@inner_block) %>
      </dl>
    """
  end

  @doc ~s"""
  Render a description list item.

  ## Attributes

  - `label` - If set renders two tags `ui_dt/1` with the contents of the attribute and `ui_dd/1` with the inner contents of the component.
    If you need to set more custom content on the `ui_dt/1` you can omit this attribute, and provide `ui_dt/1` and `ui_dd/1` yourself
    in the inner conten.
  - `value` - If `label` is set, a `value` can be specified instead of using the inner content of the component.
  - `class` - Extra classes to pass to the `div` tag. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `div` tag.
  """
  def ui_dl_item(assigns) do
    extra = assigns_to_attributes(assigns, [:class, :label, :value])

    # u-gap-l and u-gap-xl in 5.0.0 are equivalent to respectively u-gap-m and u-gap-l in 4.3.0
    gap_class =
      if Bitstyles.version(:tuple) >= {5, 0, 0} do
        "u-gap-l"
      else
        "u-gap-m"
      end

    assigns =
      assigns
      |> assign(extra: extra)
      |> assign(gap_class: gap_class)

    ~H"""
      <div class={classnames(["a-dl__item u-grid@m u-grid-cols-3 u-padding-m-y u-padding-m@m u-items-baseline u-items-baseline",  assigns[:gap_class], assigns[:class]])} {@extra}>
        <%= if assigns[:label] do %>
          <.ui_dt><%= @label %></.ui_dt>
          <.ui_dd><%= assigns[:value] || render_slot(@inner_block) %></.ui_dd>
        <% else %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
    """
  end

  @doc ~s"""
  Render a dt tag for usage with `ui_dl_item/1`.

  ## Attributes

  - `class` - Extra classes to pass to the `dt` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `dt` tag.
  """

  def ui_dt(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <dt class={classnames(["u-font-medium u-h6 u-fg-text-darker u-margin-xs-bottom@s", assigns[:class]])} {@extra}>
      <%= render_slot(@inner_block) %>
    </dt>
    """
  end

  @doc ~s"""
  Render a dd tag for usage with `ui_dl_item/1`.

  ## Attributes

  - `class` - Extra classes to pass to the `dd` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `dd` tag.
  """

  def ui_dd(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <dd class={classnames(["u-col-span-2", assigns[:class]])} {@extra}>
      <%= render_slot(@inner_block) %>
    </dd>
    """
  end
end
