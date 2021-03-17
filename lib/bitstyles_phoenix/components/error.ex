defmodule BitstylesPhoenix.Components.Error do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @translate_mfa Application.get_env(
                   :bitstyles_phoenix,
                   :translate_errors,
                   {__MODULE__, :no_translation, []}
                 )

  import Phoenix.HTML.Tag, only: [content_tag: 3]

  alias Phoenix.HTML.Form, as: PhxForm

  @doc """
  Generates tag for inlined form input errors.

  Uses the `translate_errors` callback to translate field errors.
  """
  def ui_error(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      ui_error_tag(error, phx_feedback_for: PhxForm.input_id(form, field))
    end)
  end

  @doc """
  Generates tag for custom errors.

  When errors are given in tuples {error, error_opts} they are given to the `translate_errors` callback.

  ## Examples

      iex> safe_to_string ui_error_tag("Foo error")
      ~s(<span class="u-fg--warning">Foo error</span>)

      iex> safe_to_string ui_error_tag({"Foo error", count: 1})
      ~s(<span class="u-fg--warning">Foo error</span>)

      iex> safe_to_string ui_error_tag("Foo error", phx_feedback_for: "foo")
      ~s(<span class="u-fg--warning" phx-feedback-for="foo">Foo error</span>)
  """
  def ui_error_tag(error) do
    ui_error_tag(error, [])
  end

  def ui_error_tag({_error, _count} = error, opts) do
    ui_error_tag(translate_error(error), opts)
  end

  def ui_error_tag(error, opts) do
    content_tag(:span, error, Keyword.merge(opts, class: "u-fg--warning"))
  end

  defp translate_error(error) do
    {mod, translate_fn, args} = @translate_mfa
    apply(mod, translate_fn, args ++ [error])
  end

  def no_translation({error, _}) do
    error
  end
end
