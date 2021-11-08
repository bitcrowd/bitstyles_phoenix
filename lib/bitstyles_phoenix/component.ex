defmodule BitstylesPhoenix.Component do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import Phoenix.LiveView.Helpers
      import Phoenix.LiveView, only: [assign: 2, assign: 3, assign_new: 3]
      import BitstylesPhoenix.Helper.Classnames
      import BitstylesPhoenix.Showcase
    end
  end
end
