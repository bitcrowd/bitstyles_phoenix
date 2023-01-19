defmodule BitstylesPhoenix.Bitstyles do
  @moduledoc false

  @default_version "4.3.0"
  @cdn_url "https://cdn.jsdelivr.net/npm/bitstyles"

  def cdn_url do
    "#{@cdn_url}@#{@default_version}"
  end

  def autoprefixer do
    Application.get_env(:bitstyles_phoenix, :autoprefixer, true)
  end

  @doc """
  Returns the classnames for the configured version.
  Input classnames are assumed to be from the #{@default_version} version of bitstyles.
  """
  def classname(name), do: classname(name, version())

  def classname(class, version) when version > "4.3.0" do
    IO.warn("Version #{version} of bitstyles is not yet supported")
    class
  end

  def classname(class, version) when version >= "4.2.0", do: class

  def classname(class, version) when version >= "4.0.0" do
    mapping =
      case class do
        "u-border-radius-" <> variant -> "u-round-#{variant}"
        "u-height-stretch" -> "u-height-100vh"
        _ -> class
      end

    classname(mapping, "4.2.0")
  end

  def classname(class, version) when version >= "2.0.0" do
    # credo:disable-for-previous-line Credo.Check.Refactor.CyclomaticComplexity

    mapping =
      case class do
        # Make sure that we leave the classes in place that are old anyway (update compatibility)
        "u-bg--" <> _ -> class
        "u-fg--" <> _ -> class
        "u-font--" <> _ -> class
        "u-line-height--" <> _ -> class
        "u-text--" <> _ -> class
        "u-round--" <> _ -> class
        # Make sure we port back already updated classes
        "u-bg-" <> variant -> "u-bg--#{variant}"
        "u-fg-" <> variant -> "u-fg--#{variant}"
        "u-font-" <> variant -> "u-font--#{variant}"
        "u-line-height-" <> variant -> "u-line-height--#{variant}"
        "u-text-" <> variant -> "u-text--#{variant}"
        "u-round-" <> variant -> "u-round--#{variant}"
        "u-border-radius-" <> variant -> "u-round--#{variant}"
        "u-overflow-x-auto" -> "u-overflow--x"
        "u-overflow-y-auto" -> "u-overflow--y"
        _ -> class
      end

    classname(mapping, "4.0.0")
  end

  def classname(class, version) when version >= "1.5.0" do
    mapping =
      case class do
        "u-flex-shrink-" <> number -> "u-flex__shrink-#{number}"
        "u-flex-grow-" <> number -> "u-flex__grow-#{number}"
        "u-flex-wrap" -> "u-flex--wrap"
        "u-flex-col" -> "u-flex--col"
        _ -> class
      end

    classname(mapping, "2.0.0")
  end

  def classname(class, version) when version >= "1.3.0" do
    mapping =
      case class do
        "u-grid-cols-" <> number -> "u-grid--#{number}-col"
        "u-col-span-" <> number -> "u-grid__col-span-#{number}"
        "u-col-start-" <> number -> "u-grid__col-#{number}"
        _ -> class
      end

    classname(mapping, "1.5.0")
  end

  def classname(_class, version) do
    raise("""
    The version #{version} of bitstyles is not supported. The helpers will produce incorrect classes.
    Please upgrade bitsyles and set the `bitsyles_version` to the updated version.
    """)
  end

  def version do
    Application.get_env(:bitstyles_phoenix, :bitstyles_version, @default_version)
  end
end
