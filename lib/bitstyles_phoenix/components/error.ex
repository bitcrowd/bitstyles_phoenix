defmodule BitstylesPhoenix.Components.Error do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @translate_mfa Application.get_env(
                   :bitstyles_phoenix,
                   :translate_errors,
                   {__MODULE__, :no_translation, []}
                 )

  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def ui_error(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error), class: "u-fg--warning")
    end)
  end

  defp translate_error(error) do
    {mod, translate_fn, args} = @translate_mfa
    apply(mod, translate_fn, args ++ [error])
  end

  def no_translation(error) do
    error
  end
end
