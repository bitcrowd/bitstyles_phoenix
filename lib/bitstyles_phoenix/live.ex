defmodule BitstylesPhoenix.Live do
  @moduledoc """
  Use this module to import all `BitstylesPhoenix.Live` components at once.
  ```
  use BitstylesPhoenix.Live
  ```
  """

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Live.Dropdown
      import BitstylesPhoenix.Live.Sidebar
    end
  end
end
