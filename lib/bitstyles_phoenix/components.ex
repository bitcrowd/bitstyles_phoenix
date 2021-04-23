defmodule BitstylesPhoenix.Components do
  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Badge
      import BitstylesPhoenix.Button
      import BitstylesPhoenix.Error
      import BitstylesPhoenix.Flash
      import BitstylesPhoenix.Form
      import BitstylesPhoenix.Icon
      import BitstylesPhoenix.Time
    end
  end
end
