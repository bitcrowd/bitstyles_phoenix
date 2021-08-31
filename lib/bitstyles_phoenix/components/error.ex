defmodule BitstylesPhoenix.Error do
  import BitstylesPhoenix.Showcase
  import Phoenix.HTML, only: [sigil_E: 2]
  import Phoenix.HTML.Tag, only: [content_tag: 3]
  alias Phoenix.HTML.Form, as: PhxForm

  @moduledoc """
  Component for showing UI errors.
  """

  @doc """
  Generates tag for inlined form input errors.

  Uses the `translate_errors` callback to translate field errors.
  """

  story("A single error", """
      iex> safe_to_string ui_errors(@error_form, :single)
      ~s(<span class="u-fg-warning" phx-feedback-for="user_single">is too short</span>)
  """)

  story("Multiple errors", """
      iex> safe_to_string ui_errors(@error_form, :multiple)
      ~s(<ul class=\"u-padding-l-left u-fg-warning\">
        <li><span class=\"u-fg-warning\" phx-feedback-for=\"user_multiple\">is simply bad</span></li>
        <li><span class=\"u-fg-warning\" phx-feedback-for=\"user_multiple\">not fun</span></li>
      </ul>
      )
  """)

  def ui_errors(form, field) do
    errors = Keyword.get_values(form.errors, field)

    case errors do
      [] ->
        ""

      [error] ->
        ui_error(form, field, error)

      errors ->
        ~E"""
        <ul class="u-padding-l-left u-fg-warning"><%= for error <- errors do %>
          <li><%= ui_error(form, field, error) %></li><% end %>
        </ul>
        """
    end
  end

  @doc false
  @deprecated "Use ui_errors/2 instead"
  def ui_error(form, field) do
    ui_errors(form, field)
  end

  defp ui_error(form, field, error) do
    ui_error_tag(error, phx_feedback_for: PhxForm.input_id(form, field))
  end

  @doc """
  Generates tag for custom errors.

  When errors are given in tuples {error, error_opts} they are given to the `translate_errors` callback.

  The error will be rendered with the warning color, as specified in [bitstyles colors](https://bitcrowd.github.io/bitstyles/?path=/docs/utilities-fg--warning).
  """

  story("An error tag", """
      iex> safe_to_string ui_error_tag("Foo error")
      ~s(<span class="u-fg-warning">Foo error</span>)
  """)

  story("An error tag with a gettext tuple (processed by the default callback)", """
      iex> safe_to_string ui_error_tag({"Foo error", count: 1})
      ~s(<span class="u-fg-warning">Foo error</span>)
  """)

  story("An error tag with options", """
      iex> safe_to_string ui_error_tag("Foo error", phx_feedback_for: "foo")
      ~s(<span class="u-fg-warning" phx-feedback-for="foo">Foo error</span>)
  """)

  def ui_error_tag(error) do
    ui_error_tag(error, [])
  end

  def ui_error_tag({_error, _count} = error, opts) do
    ui_error_tag(translate_error(error), opts)
  end

  def ui_error_tag(error, opts) do
    content_tag(:span, error, Keyword.merge(opts, class: "u-fg-warning"))
  end

  defp translate_error(error) do
    {mod, translate_fn, args} =
      Application.get_env(
        :bitstyles_phoenix,
        :translate_errors,
        {__MODULE__, :no_translation, []}
      )

    apply(mod, translate_fn, args ++ [error])
  end

  def no_translation({error, _}) do
    error
  end
end
