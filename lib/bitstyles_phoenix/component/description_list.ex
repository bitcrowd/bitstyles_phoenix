defmodule BitstylesPhoenix.Component.DescriptionList do
  use BitstylesPhoenix.Component

  @moduledoc """
  The description list components.
  """

  story(
    "With items (short-cut form)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dl>
        ...>   <:item label="Length">8</:item>
        ...>   <:item label="Inserted at">2007-01-02</:item>
        ...> </.ui_dl>
        ...> """
        """
        <dl class="a-dl">
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m">
            <dt class="u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s">
              Length
            </dt>
            <dd class="u-col-span-2">
              8
            </dd>
          </div>
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m">
            <dt class="u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s">
              Inserted at
            </dt>
            <dd class="u-col-span-2">
              2007-01-02
            </dd>
          </div>
        </dl>
        """
    ''',
    module: true,
    width: "100%"
  )

  story(
    "With items (short-cut and long form) and extra attributes",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_dl class="extra" data-foo="baz">
        ...>   <:item label="Length" class="u-fg--brand-2">8</:item>
        ...>   <:item>
        ...>     <.ui_dt class="u-fg--brand-1" data-foo="bar">Some</.ui_dt>
        ...>     <.ui_dd class="u-fg--brand-1" data-foo="bar">Tag</.ui_dd>
        ...>   </:item>
        ...>   <:item>
        ...>     <.ui_dt><pre>Tag</pre></.ui_dt>
        ...>     <.ui_dd>Value</.ui_dd>
        ...>   </:item>
        ...> </.ui_dl>
        ...> """
        """
        <dl class="a-dl extra" data-foo="baz">
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m u-fg--brand-2">
            <dt class="u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s">
              Length
            </dt>
            <dd class="u-col-span-2">
              8
            </dd>
          </div>
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m">
            <dt class="u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s u-fg--brand-1" data-foo="bar">
              Some
            </dt>
            <dd class="u-col-span-2 u-fg--brand-1" data-foo="bar">
              Tag
            </dd>
          </div>
          <div class="a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m">
            <dt class="u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s">
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
  Render a description list with items.

  ## Attributes

  - `class` - Extra classes to pass to the `dl` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `dl` tag.

  ## Attributes - `item` slot

  - `label` - If set renders two tags `ui_dt/1` with the contents of the attribute and `ui_dd/1` with the inner contents of the slot.
    If you need to set more custom content on the `ui_dt/1` you can omit this attribute, and provide `ui_dt/1` and `ui_dd/1` yourself
    in the inner conten.
  - `class` - Extra classes to pass to the `li` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `li` tag.

  See [bitstyles description list docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-description-list--description-list) for examples.
  """

  def ui_dl(assigns) do
    extra = assigns_to_attributes(assigns, [:item, :class])
    assigns = assign(assigns, extra: extra)

    ~H"""
      <dl class={classnames(["a-dl", assigns[:class]])} {@extra}>
        <%= for item <- @item do %>
          <div
            class={classnames(["a-dl__item u-grid@m u-grid-cols-3 u-gap-m u-padding-m-y u-padding-m@m", item[:class]])}
            {assigns_to_attributes(item, [:class, :label])}>
            <%= if item[:label] do %>
              <.ui_dt><%= item[:label] %></.ui_dt>
              <.ui_dd><%= render_slot(item) %></.ui_dd>
            <% else %>
              <%= render_slot(item) %>
            <% end %>
          </div>
        <% end %>
      </dl>
    """
  end

  @doc ~s"""
  Render a dt tag for usage with `ui_dl/1`.

  ## Attributes

  - `class` - Extra classes to pass to the `dt` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the `dt` tag.
  """

  def ui_dt(assigns) do
    extra = assigns_to_attributes(assigns, [:class])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <dt class={classnames(["u-font--medium u-h6 u-fg--gray-50 u-margin-xs-bottom@s", assigns[:class]])} {@extra}>
      <%= render_slot(@inner_block) %>
    </dt>
    """
  end

  @doc ~s"""
  Render a dd tag for usage with `ui_dl/1`.

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
