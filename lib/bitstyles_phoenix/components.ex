defmodule BitstylesPhoenix.Components do
  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Components.Badge
      import BitstylesPhoenix.Components.Button
      import BitstylesPhoenix.Components.Error
      import BitstylesPhoenix.Components.Flash
      import BitstylesPhoenix.Components.Form
      import BitstylesPhoenix.Components.Icon
      import BitstylesPhoenix.Components.Time
    end
  end
end
