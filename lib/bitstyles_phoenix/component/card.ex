defmodule BitstylesPhoenix.Component.Card do
  use BitstylesPhoenix.Component
  import BitstylesPhoenix.Component.Flash

  @moduledoc """
  A Card component.
  """

  @doc ~S"""
    Renders a card component. The card component can have default and large sizes,
    It accepts a slot for content.
  """

  story(
    "Default Card",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_card><p>Hello world</p></.ui_card>
        ...> """
    ''',
    '''
        """
        <article class="a-card">
          <p>
            Hello world
          </p>
        </article>
        """
    '''
  )

  story(
    "Large Card",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_card size="l"><p>Hello world</p></.ui_card>
        ...> """
    ''',
    '''
        """
        <article class="a-card a-card-l">
          <p>
            Hello world
          </p>
        </article>
        """
    '''
  )

  story(
    "Large Card with header",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_card size="l">
        ...>  <:card_header variant="danger">Its me mario</:card_header>
        ...>  <p>Hello world</p>
        ...> </.ui_card>
        ...> """
    ''',
    '''
        """
        <article class="a-card a-card-l">
          <div aria-live="polite" class="u-padding-l1-y a-flash a-flash--danger a-card-l__header">
            <div class="a-content u-flex u-items-center u-font-medium">
              Its me mario
            </div>
          </div>
          <p>
            Hello world
          </p>
        </article>
        """
    '''
  )

  story(
    "Small Card with header",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_card>
        ...>  <:card_header variant="danger">Its me mario</:card_header>
        ...>  <p>Hello world</p>
        ...> </.ui_card>
        ...> """
    ''',
    '''
        """
        <article class="a-card">
          <div aria-live="polite" class="u-padding-l1-y a-flash a-flash--danger a-card__header">
            <div class="a-content u-flex u-items-center u-font-medium">
              Its me mario
            </div>
          </div>
          <p>
            Hello world
          </p>
        </article>
        """
    '''
  )

  def ui_card(assigns) do
    class =
      classnames([
        "a-card",
        {"a-card-#{assigns[:size]}", assigns[:size] != nil},
        assigns[:class]
      ])

    extra =
      assigns
      |> assigns_to_attributes([:class, :size, :card_header])

    {card_header, card_header_extra} =
      assigns_from_single_slot(assigns, :card_header, optional: true)

    card_header_class =
      classnames([
        {"a-card-#{assigns[:size]}__header", !is_nil(assigns[:size])},
        {"a-card__header", is_nil(assigns[:size])},
        card_header[:class]
      ])

    assigns =
      assign(assigns,
        extra: extra,
        class: class,
        card_header_extra: card_header_extra,
        card_header_class: card_header_class
      )

    ~H"""
    <article class={@class} {@extra}>
      <%= if assigns[:card_header] do %>
        <.ui_flash class={@card_header_class} {@card_header_extra}>
          <%= render_slot(@card_header) %>
        </.ui_flash>
      <% end %>
      <%= render_slot(@inner_block) %>
    </article>
    """
  end
end
