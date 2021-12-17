defmodule BitstylesPhoenix.Helper.Classnames do
  alias BitstylesPhoenix.Bitstyles

  @default_prefix "e2e-"

  @moduledoc """
  The very best of NPM, now for elixir.
  """

  @doc """
  Concatenates lists of class names, with trimming and conditionals.

  Classes prefixes with `e2e-` are removed by default. This behaviour can be configured with
  the `trim_e2e_classes` configuration. Check `BitstylesPhoenix` top level documentation for
  more information on configuration options.

  ## Examples

      iex> classnames("foo")
      "foo"

      iex> classnames("e2e-out")
      false

      iex> classnames(nil)
      false

      iex> classnames("  foo    ")
      "foo"

      iex> classnames("  foo bar  ")
      "foo bar"

      iex> classnames(["foo", "bar"])
      "foo bar"

      iex> classnames(["foo", "bar baz"])
      "foo bar baz"

      iex> classnames(:foo)
      "foo"

      iex> classnames({"foo", 1 == 1})
      "foo"

      iex> classnames({"foo", 1 == 2})
      false

      iex> classnames(["  foo  boing  ", {"bar", 1 == 2}, :baz])
      "foo boing baz"
  """
  def classnames(arg, opts \\ [backwards_compatible: true]) do
    arg
    |> List.wrap()
    |> Enum.map(&normalize/1)
    |> Enum.flat_map(&split/1)
    |> Enum.reject(&remove_class?/1)
    |> Enum.uniq()
    |> Enum.map_join(" ", &bitstyles_version(&1, opts))
    |> case do
      "" -> false
      classnames -> classnames
    end
  end

  defp bitstyles_version(name, opts) do
    if Keyword.get(opts, :backwards_compatible) do
      Bitstyles.classname(name)
    else
      name
    end
  end

  defp normalize(nil), do: ""
  defp normalize({class, true}), do: classnames(class)
  defp normalize({_class, false}), do: ""
  defp normalize({_class, nil}), do: ""
  defp normalize(class) when is_binary(class), do: String.trim(class)
  defp normalize(class) when is_atom(class), do: class |> to_string() |> String.trim()

  defp split(class), do: String.split(class, " ")

  defp remove_class?(""), do: true

  defp remove_class?(class) when is_binary(class) do
    config = Application.get_env(:bitstyles_phoenix, :trim_e2e_classes, [])
    prefix = Keyword.get(config, :prefix, @default_prefix)
    Keyword.get(config, :enabled, true) && String.starts_with?(class, prefix)
  end

  defp remove_class?(_value), do: false
end
