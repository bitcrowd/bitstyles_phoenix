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

  @type assigns_from_single_slot_option ::
          {:exclude, [atom()]} | {:default, fun() | term()} | {:with, fun() | atom()}
  @spec assigns_from_single_slot(assigns :: map(), slot_name :: atom(), [
          assigns_from_single_slot_option
        ]) :: map()
  def assigns_from_single_slot(assigns, slot_name, opts \\ []) do
    case assigns[slot_name] do
      [slot] ->
        extra = assigns_to_attributes(slot, Keyword.get(opts, :exclude, []))

        opts
        |> Keyword.fetch!(:with)
        |> case do
          value when is_atom(value) -> [{value, extra}]
          with_fn when is_function(with_fn, 2) -> with_fn.(slot, extra)
        end

      nil ->
        if Keyword.has_key?(opts, :default) do
          case Keyword.get(opts, :default) do
            value when is_function(value) -> value.()
            value -> value
          end
        else
          raise "please specify #{slot_name} slot"
        end

      _ ->
        raise "please specify at most one #{slot_name} slot"
    end
  end
end
