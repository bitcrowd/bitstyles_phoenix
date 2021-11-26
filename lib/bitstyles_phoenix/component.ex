defmodule BitstylesPhoenix.Component do
  @moduledoc false

  import Phoenix.LiveView.Helpers

  defmacro __using__(_) do
    quote do
      import Phoenix.LiveView.Helpers
      import Phoenix.LiveView, only: [assign: 2, assign: 3, assign_new: 3]
      import BitstylesPhoenix.Helper.Classnames
      import BitstylesPhoenix.Showcase
      import BitstylesPhoenix.Component
    end
  end

  @type assigns_from_single_slot_option :: {:exclude, [atom()]} | {:optional, boolean()}
  @spec assigns_from_single_slot(assigns :: map(), slot_name :: atom(), [
          assigns_from_single_slot_option
        ]) :: {slot :: map(), attributes :: keyword()}
  def assigns_from_single_slot(assigns, slot_name, opts \\ []) do
    case assigns[slot_name] do
      [slot] ->
        extra = assigns_to_attributes(slot, Keyword.get(opts, :exclude, []))
        {slot, extra}

      nil ->
        if Keyword.has_key?(opts, :optional) do
          {nil, []}
        else
          raise "please specify #{slot_name} slot"
        end

      _ ->
        raise "please specify at most one #{slot_name} slot"
    end
  end
end
