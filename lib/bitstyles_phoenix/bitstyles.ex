defmodule BitstylesPhoenix.Bitstyles do
  @moduledoc false

  @default_version "3.0.0"
  @cdn_url "https://cdn.jsdelivr.net/npm/bitstyles"

  def cdn_url do
    "#{@cdn_url}@#{@default_version}"
  end

  @doc """
  Returns the classnames for the configured version.
  Input classnames are assumed to be from the #{@default_version} version of bitstyles.
  """
  def classname(name), do: classname(name, version())

  def classname(class, version) when version > "3.0.0" do
    IO.warn("Version #{version} of bitstyles is not yet supported")
    class
  end

  def classname(class, version) when version >= "2.0.0", do: class

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
