defmodule BitstylesPhoenix.Components do
  @moduledoc """
  Shortcut usage macro to import all components at once, see `BitstylesPhoenix`.
  """

  defmacro __using__(_) do
    for c <- BitstylesPhoenix.MixProject.bitstyles_phoenix_components() do
      quote do
        import unquote(c)
      end
    end
  end
end
