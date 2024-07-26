defmodule BitstylesPhoenix.Bitstyles.Version do
  @moduledoc false

  @default_version "5.0.1"

  def version do
    to_tuple(version_string())
  end

  def version_string do
    bitstyles_version_override = Process.get(:bitstyles_phoenix_bistyles_version)

    bitstyles_version_override ||
      Application.get_env(:bitstyles_phoenix, :bitstyles_version, @default_version)
  end

  def default_version do
    to_tuple(@default_version)
  end

  def default_version_string, do: @default_version

  def to_tuple(version) when is_tuple(version), do: version

  def to_tuple(version) when is_binary(version) do
    version
    |> String.split(".")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def to_string(version) when is_binary(version), do: version

  def to_string(version) when is_tuple(version) do
    version
    |> Tuple.to_list()
    |> Enum.map_join(".", &Kernel.to_string/1)
  end
end
