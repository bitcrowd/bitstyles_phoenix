defmodule BitstylesPhoenix.Alpine3 do
  @moduledoc """
  Use this module to import all `BitstylesPhoenix.Alpine3` components at once.
  ```
  use BitstylesPhoenix.Alpine
  ```
  """
  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Alpine3.Dropdown
    end
  end
end
