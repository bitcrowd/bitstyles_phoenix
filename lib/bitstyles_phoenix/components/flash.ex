defmodule BitstylesPhoenix.Flash do
  import Phoenix.LiveView.Helpers
  import BitstylesPhoenix.Classnames
  import BitstylesPhoenix.Showcase

  @moduledoc """
  Component for building flash messages.
  """

  @doc ~s"""
  Inform the user of a global or important event, such as may happen after a page reload. There are several variants, which use color, iconography, and html attributes to indicate severity.

  See [https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1)

  - *variant* - specifies which visual variant of flash you want, from those available in CSS. Defaults include: `brand-1`, `warning`, `info`, `danger`

  """

  story("Flash brand 1", '''
      iex> assigns = %{}
      iex> ~H"""
      ...> <.ui_flash variant="brand-1">Something you may be interested to hear</.ui_flash>
      ...> """ |> h2s()
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--brand-1">
        <div class="a-content u-flex u-items-center u-font--medium">
          Something you may be interested to hear
        </div>
      </div>)
  ''')

  # story("Flash success", """
  #     iex> safe_to_string ui_flash("Saved successfully", variant: "positive")
  #     ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--positive"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  # """)

  # story("Flash warning", """
  #     iex> safe_to_string ui_flash("Saved successfully", variant: "warning")
  #     ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--warning"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  # """)

  # story("Flash danger", """
  #     iex> safe_to_string ui_flash("Saved successfully", variant: "danger")
  #     ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--danger"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  # """)

  # story("Flash with a block", """
  #     iex> safe_to_string(ui_flash(variant: "danger") do
  #     ...>   "Saved successfully"
  #     ...> end)
  #     ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--danger"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  # """)

  def ui_flash(assigns) do
    variant = assigns[:variant]

    classname =
      classnames([
        "u-padding-l-y a-flash",
        {"a-flash--#{variant}", variant != nil},
        assigns[:class]
      ])

    inner_classname =
      classnames(["a-content u-flex u-items-center u-font--medium", assigns[:inner_class]])

    extra = assigns_to_attributes(assigns, [:class, :inner_class, :variant])

    assigns =
      assigns
      |> Phoenix.LiveView.assign(:classname, classname)
      |> Phoenix.LiveView.assign(:inner_classname, inner_classname)
      |> Phoenix.LiveView.assign(:extra, extra)

    ~H"""
    <div aria-live="polite" class={@classname} {@extra}>
      <div class={inner_classname}>
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
