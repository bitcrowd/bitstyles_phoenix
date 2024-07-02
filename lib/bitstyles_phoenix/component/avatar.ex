defmodule BitstylesPhoenix.Component.Avatar do
  use BitstylesPhoenix.Component

  @moduledoc """
  An Avatar component.
  """

  @doc ~S"""
  Renders an avatar component.

  The avatar component can have medium and large sizes, and it defaults to medium. It accepts a slot for text.
  Always provide a source and alt. The width and height have 32px default values and can be overidden.

  See the [bitstyles avatar docs](https://bitcrowd.github.io/bitstyles/?path=/docs/atoms-avatar--a-avatar-m) for further info.
  """

  story(
    "Default avatar",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_avatar src="https://placehold.co/100x100" alt="Username’s avatar"/>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-items-center">
          <div class="a-avatar">
            <img height="32" width="32" alt="Username’s avatar" src="https://placehold.co/100x100"/>
          </div>
        </div>
        """
    '''
  )

  story(
    "With extra class",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_avatar src="https://placehold.co/100x100" class="foo bar" alt="Username’s avatar"/>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-items-center">
          <div class="a-avatar foo bar">
            <img height="32" width="32" alt="Username’s avatar" src="https://placehold.co/100x100"/>
          </div>
        </div>
        """
    '''
  )

  story(
    "Large avatar",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_avatar size="l" src="https://placehold.co/100x100" alt="Username’s avatar" height="46" width="46"/>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-items-center">
          <div class="a-avatar a-avatar--l">
            <img alt="Username’s avatar" height="46" src="https://placehold.co/100x100" width="46"/>
          </div>
        </div>
        """
    '''
  )

  story(
    "Avatar with a text",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_avatar src="https://placehold.co/100x100" alt="Username’s avatar"> Username </.ui_avatar>
        ...> """
    ''',
    '''
        """
        <div class="u-flex u-items-center">
          <div class="a-avatar">
            <img height="32" width="32" alt="Username’s avatar" src="https://placehold.co/100x100"/>
          </div>
          <span class="u-margin-s2-left">
            Username
          </span>
        </div>
        """
    '''
  )

  def ui_avatar(assigns) do
    class =
      classnames([
        "a-avatar",
        {"a-avatar--#{assigns[:size]}", assigns[:size] != nil},
        assigns[:class]
      ])

    extra =
      assigns
      |> assigns_to_attributes([:class, :size])
      |> put_defaults

    assigns = assign(assigns, extra: extra, class: class)

    ~H"""
    <div class={classnames("u-flex u-items-center")}>
      <div class={@class}>
        <img {@extra} />
      </div>
      <%= if assigns[:inner_block] do %>
        <span class={classnames("u-margin-s2-left")}>
         <%= render_slot(@inner_block) %>
        </span>
      <% end %>
    </div>
    """
  end

  @default_size 32
  defp put_defaults(opts) do
    opts
    |> Keyword.put_new(:width, @default_size)
    |> Keyword.put_new(:height, @default_size)
  end
end
