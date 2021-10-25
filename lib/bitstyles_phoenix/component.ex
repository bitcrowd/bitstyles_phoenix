defmodule BitstylesPhoenix.Component do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Classnames
      import BitstylesPhoenix.Showcase
      import Phoenix.LiveView.Helpers
      import Phoenix.LiveView, only: [assign: 2]
    end
  end
end
