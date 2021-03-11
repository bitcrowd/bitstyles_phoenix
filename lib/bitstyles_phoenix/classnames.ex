defmodule BitstylesPhoenix.Classnames do
  @moduledoc """
  The very best of NPM, now for elixir.
  """

  @trim_e2e_classes Application.compile_env(:bitstyles_phoenix, :trim_e2e_classes, true)

  @doc """
  Concatenates lists of class names, with trimming and conditionals.

  `e2e-` classes are trimmed at compile time. This can be disabled for
  test environments via `trim_e2e_classes`.

  ## Examples

      iex> classnames("foo")
      "foo"

      iex> classnames("e2e-out")
      ""

      iex> classnames(nil)
      ""

      iex> classnames("  foo    ")
      "foo"

      iex> classnames(["foo", "bar"])
      "foo bar"

      iex> classnames(:foo)
      "foo"

      iex> classnames({"foo", 1 == 1})
      "foo"

      iex> classnames({"foo", 1 == 2})
      ""

      iex> classnames(["  foo    ", {"bar", 1 == 2}, :baz])
      "foo baz"
  """
  def classnames(arg) do
    arg
    |> List.wrap()
    |> Enum.map(&normalize/1)
    |> Enum.flat_map(&split/1)
    |> Enum.reject(&remove_class?/1)
    |> Enum.uniq()
    |> Enum.join(" ")
  end

  @doc """
  Extended classnames.

  `e2e-` classes are trimmed at compile time. This can be disabled for
  test environments via `trim_e2e_classes`.

  Conveniently accepts a (whitespace-separated) string or a list. If the list contains any
  conditional expressions, they are evaluated at runtime.
  """
  defmacro xclassnames(arg) do
    classes =
      arg
      |> List.wrap()
      |> Enum.flat_map(&safe_split/1)
      |> Enum.reject(&remove_class?/1)

    if Enum.any?(classes, &Kernel.is_tuple/1) do
      quote do
        classnames(unquote(classes))
      end
    else
      classes = classnames(classes)

      quote do
        unquote(classes)
      end
    end
  end

  defp normalize(nil), do: ""
  defp normalize({class, true}), do: classnames(class)
  defp normalize({_class, false}), do: ""
  defp normalize(class) when is_binary(class), do: String.trim(class)
  defp normalize(class) when is_atom(class), do: class |> to_string() |> String.trim()

  defp split(class), do: String.split(class, " ")

  defp safe_split(class) when is_binary(class), do: String.split(class, " ")
  defp safe_split(value), do: value

  defp remove_class?(""), do: true

  if @trim_e2e_classes do
    defp remove_class?(class) when is_binary(class), do: String.starts_with?(class, "e2e-")
  end

  defp remove_class?(_value), do: false
end
