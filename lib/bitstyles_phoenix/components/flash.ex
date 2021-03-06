defmodule BitstylesPhoenix.Flash do
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Classnames
  import BitstylesPhoenix.Showcase

  @moduledoc """
  Component for building flash messages.
  """

  @doc ~s"""
  Inform the user of a global or important event, such as may happen after a page reload. There are several variants, which use color, iconography, and html attributes to indicate severity.

  See [https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-flashes--flash-brand-1)

  `opts[:variant]` — specifies which visual variant of flash you want, from those available in CSS. Defaults include: `brand-1`, `warning`, `info`, `danger`
  """

  story("Flash brand 1", """
      iex> safe_to_string ui_flash("Something you may be interested to hear", variant: "brand-1")
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--brand-1"><div class="a-content u-flex u-items-center u-font--medium">Something you may be interested to hear</div></div>)
  """)

  story("Flash success", """
      iex> safe_to_string ui_flash("Saved successfully", variant: "positive")
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--positive"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  """)

  story("Flash warning", """
      iex> safe_to_string ui_flash("Saved successfully", variant: "warning")
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--warning"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  """)

  story("Flash danger", """
      iex> safe_to_string ui_flash("Saved successfully", variant: "danger")
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--danger"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  """)

  story("Flash with a block", """
      iex> safe_to_string(ui_flash(variant: "danger") do
      ...>   "Saved successfully"
      ...> end)
      ~s(<div aria-live="polite" class="u-padding-l-y a-flash a-flash--danger"><div class="a-content u-flex u-items-center u-font--medium">Saved successfully</div></div>)
  """)

  def ui_flash(opts, do: contents) do
    ui_flash(contents, opts)
  end

  def ui_flash(contents, opts) do
    classname =
      classnames(["u-padding-l-y a-flash", {"a-flash--#{opts[:variant]}", opts[:variant] != nil}])

    content_tag(:div, class: classname, "aria-live": "polite") do
      content_tag(:div, contents, class: "a-content u-flex u-items-center u-font--medium")
    end
  end
end
