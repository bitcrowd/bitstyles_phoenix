defmodule BitstylesPhoenix.Bitstyles do
  @moduledoc false

  @default_version "5.0.1"
  @cdn_url "https://cdn.jsdelivr.net/npm/bitstyles"

  def cdn_url do
    "#{@cdn_url}@#{version()}"
  end

  @doc """
  Returns the classnames for the configured version.
  Input classnames are assumed to be from the #{@default_version} version of bitstyles.
  """
  def classname(name), do: classname(name, version())

  def classname(class, version) when version > "5.0.1" do
    IO.warn("Version #{version} of bitstyles is not yet supported")
    class
  end

  # Note about class renaming:
  # A renaming of "class-name-A" (newer) to "class-name-B" (older) can only be done via this module if
  # the "class-name-A" does not also exist in older versions of bitstyles with a different meaning.
  # If it does exist, then doing this renaming in the classname/2 function would make it impossible
  # for users of older bitstyles to use the "class-name-A" classname.

  def classname(class, version) when version >= "5.0.0" do
    class
  end

  def classname(class, version) when version >= "4.2.0" do
    sizes_renaming = %{
      "3xs" => "xxxs",
      "2xs" => "xxs",
      "2xl" => "xxl",
      "3xl" => "xxxl"
    }

    class =
      if String.starts_with?(class, "u-") do
        Enum.reduce(sizes_renaming, class, fn {new_size, old_size}, acc ->
          String.replace(acc, "-#{new_size}", "-#{old_size}")
        end)
      else
        class
      end

    border_color_renaming = %{
      "u-border-gray-light" => "u-border-gray-10",
      "u-border-gray-dark" => "u-border-gray-70"
    }

    class =
      Enum.reduce(border_color_renaming, class, fn {new_border_color, old_border_color}, acc ->
        String.replace(acc, new_border_color, old_border_color)
      end)

    class =
      case class do
        "u-list-none" -> "a-list-reset"
        "a-badge--text" -> "a-badge--gray"
        "u-fg-text" -> "u-fg-gray-30"
        "u-fg-text-darker" -> "u-fg-gray-50"
        "u-bg-gray-darker" -> "u-bg-gray-80"
        class -> class
      end

    classname(class, "5.0.0")
  end

  def classname(class, version) when version >= "4.0.0" do
    mapping =
      case class do
        "u-border-radius-" <> variant -> "u-round-#{variant}"
        _ -> class
      end

    classname(mapping, "4.3.0")
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
    bitstyles_version_override = Process.get(:bitstyles_phoenix_bistyles_version)

    bitstyles_version_override ||
      Application.get_env(:bitstyles_phoenix, :bitstyles_version, @default_version)
  end

  def default_version do
    @default_version
  end
end
