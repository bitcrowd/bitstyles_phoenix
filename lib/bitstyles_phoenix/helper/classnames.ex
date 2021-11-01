defmodule BitstylesPhoenix.Helper.Classnames do
  @moduledoc """
  The very best of NPM, now for elixir.
  """

  @trim_e2e_classes Application.compile_env(:bitstyles_phoenix, :trim_e2e_classes)

  @doc """
  Concatenates lists of class names, with trimming and conditionals.

  `e2e-` classes are trimmed at compile time. This can be disabled for
  test environments via `trim_e2e_classes`.

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
  def classnames(arg) do
    arg
    |> List.wrap()
    |> Enum.map(&normalize/1)
    |> Enum.flat_map(&split/1)
    |> Enum.reject(&remove_class?/1)
    |> Enum.uniq()
    |> Enum.join(" ")
    |> case do
      "" -> false
      classnames -> classnames
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

  if @trim_e2e_classes[:enabled] do
    defp remove_class?(class) when is_binary(class),
      do: String.starts_with?(class, Keyword.get(@trim_e2e_classes, :prefix, "e2e-"))
  end

  defp remove_class?(_value), do: false
end
