defmodule BitstylesPhoenix.Components do
  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Components.Button
      import BitstylesPhoenix.Components.Time
      import BitstylesPhoenix.Components.Form
      import BitstylesPhoenix.Components.Icon
      import BitstylesPhoenix.Components.Error
    end
  end
end
