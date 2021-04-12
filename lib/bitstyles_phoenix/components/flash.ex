defmodule BitstylesPhoenix.Components.Flash do
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import BitstylesPhoenix.Classnames

  @moduledoc """
  Conveniences for building flash messages.
  """

  @doc ~s"""
  Inform the user of a global or important event, such as may happen after a page reload. There are several variants, which use color, iconography, and html attributes to indicate severity.

  `opts[:variant]` — specifies which visual variant of flash you want, from those available in the CSS classes e.g. `brand-1`, `warning`, `info`, `danger`

  `opts[:icon]` - optional. You can specify the icon that is rendered by name. The icon must be present in the icon svg

  ## Examples

      iex> safe_to_string ui_flash("Saved successfully", variant: "positive")
      ~s(<div class="a-flash a-flash--positive">Save</div>)

      iex> safe_to_string ui_flash("Saved successfully", variant: "positive", icon: "check")
      ~s(<div class="a-flash a-flash--positive">Save</div>)

  """
  def ui_flash(opts, do: contents) do
    ui_flash(contents, opts)
  end

  def ui_flash(contents, opts) do
    classname =
      classnames(["a-flash", {"a-flash--#{opts[:variant]}", opts[:variant] != nil}])
    content_tag(:div, contents, class: classname)
  end
end
