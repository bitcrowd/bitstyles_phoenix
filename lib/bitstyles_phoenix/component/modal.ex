defmodule BitstylesPhoenix.Component.Modal do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Content

  @moduledoc """
  The Modal component.
  """

  @doc ~s"""
  Renders a modal. Optionally can have an `overlay` slot with or without content, to change the overlay div.
  Additionally the modal can implement a `content` slot to change the content wrapper.
  If a content slot is passed, then the content of that slot is rendered as inner content of the modal, otherwise
  as a shortcut, the inner_block of the component is used.

  ## Attributes

  - `class` - Extra classes to pass to the modal. See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed to the underlying `ui_content/1` component.

  # Attributes - `overlay` slot

  - `class` - Extra classes to pass to the `main` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the main tag.

  # Attributes - `content` slot

  - `class` - Extra classes to pass to the `main` tag.
    See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - All other attributes are passed on to the main tag.


  See [bitstyles content docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-modal--informational-modal) for examples, and for the default variants available.
  """

  story(
    "Default modal",
    """
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_modal>
        ...>   Content
        ...> </.ui_modal>
        ...> """
    """,
    """
        \"""
        <div class="o-modal" aria-modal="true" role="dialog">
          <div class="o-modal__overlay">
          </div>
          <div class="a-content o-modal__content a-card u-padding-xl@m u-padding-l1 u-flex u-flex-col" role="document">
            Content
          </div>
        </div>
        \"""
    """,
    height: "400px",
    width: "100%",
    transparent: false
  )

  story(
    "Small modal",
    """
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_modal aria-labelledby="dialog-title" variant="s" class="foo">
        ...>   <:content class="bar" foo="bar">
        ...>     Content
        ...>   </:content>
        ...> </.ui_modal>
        ...> """
    """,
    """
        \"""
        <div class="o-modal foo" aria-modal="true" role="dialog" aria-labelledby="dialog-title">
          <div class="o-modal__overlay">
          </div>
          <div class="a-content a-content--s o-modal__content a-card u-padding-xl@m u-padding-l1 u-flex u-flex-col bar" foo="bar" role="document">
            Content
          </div>
        </div>
        \"""
    """,
    height: "400px",
    width: "100%",
    transparent: false
  )

  story(
    "Small modal with extra overlay",
    """
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_modal>
        ...>   <:overlay class="extra" data-foo="bar" />
        ...>   Content
        ...> </.ui_modal>
        ...> """
    """,
    """
        \"""
        <div class="o-modal" aria-modal="true" role="dialog">
          <div class="o-modal__overlay extra" data-foo="bar">
          </div>
          <div class="a-content o-modal__content a-card u-padding-xl@m u-padding-l1 u-flex u-flex-col" role="document">
            Content
          </div>
        </div>
        \"""
    """,
    height: "400px",
    width: "100%",
    transparent: false
  )

  story(
    "Small modal with extra overlay content",
    """
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_modal>
        ...>   <:overlay class="extra" data-foo="bar">
        ...>     <span class="u-hidden">Overlay content</span>
        ...>   </:overlay>
        ...>   Content
        ...> </.ui_modal>
        ...> """
    """,
    """
        \"""
        <div class="o-modal" aria-modal="true" role="dialog">
          <div class="o-modal__overlay extra" data-foo="bar">
            <span class="u-hidden">
              Overlay content
            </span>
          </div>
          <div class="a-content o-modal__content a-card u-padding-xl@m u-padding-l1 u-flex u-flex-col" role="document">
            Content
          </div>
        </div>
        \"""
    """,
    height: "400px",
    width: "100%",
    transparent: false
  )

  def ui_modal(assigns) do
    {overlay, overlay_extra} = assigns_from_single_slot(assigns, :overlay, optional: true)
    overlay_class = classnames(["o-modal__overlay", overlay_extra[:class]])
    overlay_extra = Keyword.put(overlay_extra, :class, overlay_class)

    {content, content_extra} = assigns_from_single_slot(assigns, :content, optional: true)

    content_class =
      classnames([
        "o-modal__content a-card u-padding-xl@m u-padding-l1 u-flex u-flex-col",
        content_extra[:class]
      ])

    content_extra = Keyword.merge(content_extra, class: content_class, variant: assigns[:variant])

    assigns =
      assign(assigns,
        overlay: overlay,
        overlay_extra: overlay_extra,
        content: content,
        content_extra: content_extra
      )

    ~H"""
    <div
      class={classnames(["o-modal", assigns[:class]])}
      aria-modal="true"
      role="dialog"
      {assigns_to_attributes(assigns, [:overlay, :overlay_extra, :class, :content, :content_extra, :variant])}
    >
      <div {@overlay_extra}>
        <%= if assigns[:overlay] && Map.get(assigns[:overlay], :inner_block), do: render_slot(@overlay) %>
      </div>
      <.ui_content role="document" {@content_extra}>
        <%= if assigns[:content], do: render_slot(@content), else: render_slot(@inner_block) %>
      </.ui_content>
    </div>
    """
  end
end
