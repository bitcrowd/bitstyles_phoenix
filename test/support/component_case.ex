defmodule BitstylesPhoenix.ComponentCase do
  use ExUnit.CaseTemplate

  @moduledoc false

  using do
    quote do
      use BitstylesPhoenix.Helper.ComponentRendering
    end
  end
end
