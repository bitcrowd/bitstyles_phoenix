defmodule BitstylesPhoenix.Component.UseSVG do
  use BitstylesPhoenix.Component

  @moduledoc """
  Components for rendering SVGs.
  """

  @doc ~S"""
  Renders an SVG tag with a `use` reference.
  """

  story(
    "A referenced SVG (inlined on the page)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_svg use="arrow"/>
        ...> """
        """
        <svg xmlns="http://www.w3.org/2000/svg">
          <use xlink:href="#arrow">
          </use>
        </svg>
        """
    ''',
    extra_html: """
    <svg xmlns="http://www.w3.org/2000/svg" hidden aria-hidden="true">
      <symbol id="arrow" viewBox="0 0 100 100">
        <path d="M32.83,97.22a6.07,6.07,0,1,1-8.59-8.58L58.59,54.29a6.07,6.07,0,0,0,0-8.58L24.24,11.36a6.07,6.07,0,1,1,8.59-8.58L75.76,45.71a6.07,6.07,0,0,1,0,8.58Z" fill-rule="evenodd" />
      </symbol>
    </svg>
    """
  )

  story(
    "A referenced SVG (external file)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_svg use="logo" file="assets/logo.svg" viewbox="0 0 400 280"/>
        ...> """
        """
        <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 400 280">
          <use xlink:href="assets/logo.svg#logo">
          </use>
        </svg>
        """
    ''',
    background: "white"
  )

  story(
    "A referenced SVG (external file with symbols)",
    '''
        iex> assigns = %{}
        ...> render ~H"""
        ...> <.ui_svg file="assets/icons.svg" use="icon-bin"/>
        ...> """
        """
        <svg xmlns="http://www.w3.org/2000/svg">
          <use xlink:href="assets/icons.svg#icon-bin">
          </use>
        </svg>
        """
    ''',
    background: "white"
  )

  def ui_svg(assigns) do
    extra =
      assigns
      |> assigns_to_attributes([:file, :use])
      |> Keyword.put_new(:xmlns, "http://www.w3.org/2000/svg")

    assigns = assign(assigns, href: href(assigns), extra: extra)

    ~H"""
    <svg {@extra}>
      <use xlink:href={@href} />
    </svg>
    """
  end

  defp href(assigns), do: "#{assigns[:file]}##{assigns[:use]}"
end
