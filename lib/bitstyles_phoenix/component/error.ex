defmodule BitstylesPhoenix.Component.Error do
  use BitstylesPhoenix.Component
  alias Phoenix.HTML.Form, as: PhxForm

  @moduledoc """
  Component for showing UI errors.
  """

  @doc """
  Render errors from a Phoenix.HTML.Form.

  ## Attributes

  - `form` *(required)* - The form to render the input form.
  - `field` *(required)* - The name of the field for the input.
  - `class` - Extra classes to pass to the wrapping `ul` if there are mutliple errors.
     See `BitstylesPhoenix.Helper.classnames/1` for usage.
  - `error_class` - Extra classes to pass to the error component.
     See `BitstylesPhoenix.Helper.classnames/1` for usage.

  See also `BitstylesPhoenix.Component.Form`.

  Uses the `translate_errors` MFA from the config to translate field errors (e.g. with `gettext`).
  """

  story("A single error", '''
      iex> assigns = %{form: @error_form}
      ...> render ~H"""
      ...> <.ui_errors form={@form} field={:single} />
      ...> """
      """
      <span class="u-fg--warning" phx-feedback-for="user[single]">
        is too short
      </span>
      """
  ''')

  story("Multiple errors", '''
      iex> assigns = %{form: @error_form}
      ...> render ~H"""
      ...> <.ui_errors form={@form} field={:multiple} />
      ...> """
      """
      <ul class="u-padding-l-left u-fg--warning">
        <li>
          <span class="u-fg--warning" phx-feedback-for="user[multiple]">
            is simply bad
          </span>
        </li>
        <li>
          <span class="u-fg--warning" phx-feedback-for="user[multiple]">
            not fun
          </span>
        </li>
      </ul>
      """
  ''')

  def ui_errors(assigns) do
    assigns.form.errors
    |> Keyword.get_values(assigns.field)
    |> case do
      [] ->
        ~H""

      [error] ->
        assigns = assign(assigns, error: error)

        ~H"""
          <.ui_error
            error={error}
            phx-feedback-for={PhxForm.input_name(assigns.form, assigns.field)}
            class={assigns[:error_class]} />
        """

      errors ->
        class = classnames(["u-padding-l-left u-fg--warning", assigns[:class]])
        assigns = assign(assigns, class: class)

        ~H"""
          <ul class={@class}>
            <%= for error <- errors do %>
              <li>
                <.ui_error
                  error={error}
                  phx-feedback-for={PhxForm.input_name(assigns.form, assigns.field)}
                  class={assigns[:error_class]} />
              </li>
            <% end %>
          </ul>
        """
    end
  end

  @doc """
  Generates tag for custom errors.

  ## Attributes

  - `error` *(required)* - The error to render (expected to be a tuple with `{message :: String.t(), opts :: keyword()}`).
  - All other attributes are passed to the outer `span` tag.

  Uses the `translate_errors` MFA from the config to translate field errors (e.g. with `gettext`).

  The error will be rendered with the warning color, as
  specified in [bitstyles colors](https://bitcrowd.github.io/bitstyles/?path=/docs/utilities-fg--warning).
  """

  story("An error tag", '''
      iex> assigns = %{}
      ...> render ~H"""
      ...> <.ui_error error={{"Foo error", []}} />
      ...> """
      """
      <span class="u-fg--warning">
        Foo error
      </span>
      """
  ''')

  story("An error tag extra options and classes", '''
      iex> assigns = %{error: {"Foo error", []}}
      ...> render ~H"""
      ...> <.ui_error error={@error} phx-feedback-for="foo" class="bar" />
      ...> """
      """
      <span class="u-fg--warning bar" phx-feedback-for="foo">
        Foo error
      </span>
      """
  ''')

  def ui_error(assigns) do
    extra = assigns_to_attributes(assigns, [:class, :error, :field, :form])
    class = classnames(["u-fg--warning", assigns[:class]])
    assigns = assign(assigns, class: class, extra: extra)

    ~H"""
    <span class={@class} {@extra}><%= translate_error(@error) %></span>
    """
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

  def no_translation(error), do: error
end
