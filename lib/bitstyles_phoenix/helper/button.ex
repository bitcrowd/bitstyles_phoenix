defmodule BitstylesPhoenix.Helper.Button do
  use Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  import Phoenix.Component
  import BitstylesPhoenix.Helper.Classnames
  import BitstylesPhoenix.Component.Icon
  import BitstylesPhoenix.Showcase

  @moduledoc """
  Helpers to create buttons and links.
  """

  @doc """
  An icon button with sr text and title. Accepts an icon name, a label and the following options:

  The icon can be either provided as icon name string, or as tuple with `{name, icon_opts}` where the name is the
  icon name and icon options that are passed as attributes to `BitstylesPhoenix.Component.Icon.ui_icon`.

  ## Options:

  - `reversed` - Icon reversed style (see examples)
  - All other options are passed to `ui_button/2`
  """
end
