defmodule BitstylesPhoenix.Components.Form do
  use Phoenix.HTML
  import BitstylesPhoenix.Classnames
  alias BitstylesPhoenix.Components.Error

  @moduledoc """
  Form-related UI components.
  The various form helpers here follow the interface provided by HTML — inputs, selects, and textareas.

  """

  @input_mapping [
    color: :color_input,
    checkbox: :checkbox,
    date: :date_input,
    datetime: :datetime_input,
    email: :email_input,
    file: :file_input,
    hidden: :hidden_input,
    number: :number_input,
    password: :password_input,
    radio: :radio_button,
    range: :range_input,
    reset: :reset,
    search: :search_input,
    telephone: :telephone_input,
    text: :text_input,
    textarea: :textarea,
    time: :time_input,
    url: :url_input
  ]

  # NOTE: The input elements are not doc-testable due to the impossibility
  #       to provide a form object as first argument without compromising the
  #       examples readability.

  @doc ~S"""
  Renders all types of `<input>` element, with the associated `<label>`s, and any errors for that field. Defaults to `type="text"`, and `maxlength="255"`.
  As with the various `text_input`, `number_input` helpers in `Phoenix.HTML.Form`, this expects the form & field as first parameters.
  `opts` will be passed on to the respective underlying Phoenix form helper, with the following additional notes:

  `form` — the form object this input is being rendered inside
  `field` — the atom for the field you’re rendering
  `opts[:type]` — the type of the input required, analogous to the input types in the HTML standard
  `opts[:e2e_classname]` — A classname that will be applied to the input for testing purposes, only on integration env
  `opts[:label]` — Override the default text to be used in the `<label>`
  `opts[:hidden_label]` — The label element will be visually hidden, but still present in the DOM

  ## Examples

      iex> ui_input(f, :field)
      ~s(<label for="field">Field</label>
      <input id="field" name="field" type="text">)

      iex> ui_input(f, :email_or_name, type: :search, placeholder: "Email or Name search", autofocus: true)
      ~s(<label for="email_or_number_or_name">Email or name</label>
      <input id="email_or_number_or_name" name="email_or_name" placeholder="Email or Name search" type="search" autofocus="">)

      iex> ui_input(f, :file, type: :file, accept: "application/pdf")
      ~s(<label for="file">File</label>
      <input accept="application/pdf" id="file" name="user[file]" type="file">)

      iex> ui_input(f, :search_term, type: :search, hidden_label: true)
      ~s(<label for="search_term" class="o-visually-hidden">Search</label>
      <input id="search_term" name="search_term" type="search">)

  """
  def ui_input(form, field, opts \\ []) do
    opts =
      opts
      |> put_type()
      |> put_default_validations()

    if opts[:type] == :checkbox || opts[:type] == :radio_button do
      wrapped_input(form, field, opts)
    else
      unwrapped_input(form, field, opts)
    end
  end

  @doc ~S"""
  Renders `<textarea>` elements, with the associated `<label>`s, and any errors for that field. As with the various form helpers in `Phoenix.HTML.Form`, this expects the form & field as first parameters.
  This is an alias for ui_input, as we’re matching the HTML elements, which present a different interface to that presented by the phoenix functions (i.e. in HTML we have <textarea>, not <input type="textarea">)
  `opts` will be passed on to the respective underlying Phoenix form helper, with the following additional notes:

  `form` — the form object this input is being rendered inside
  `field` — the atom for the field you’re rendering
  `opts[:e2e_classname]` — A classname that will be applied to the input for testing purposes, only on integration env
  `opts[:label]` — Override the default text to be used in the `<label>`

  ## Examples

      iex> ui_textarea(f, :address)
      ~s(<label for="user_address">Address</label>
      <textarea id="user_address" name="user[address]"></textarea>)

      iex> ui_textarea(f, :stringified_metadata, label: "Metadata", value: "Value here", rows: 10, style: "height: auto;")
      ~s(<label for="user_stringified_metadata">Metadata</label>
      <textarea id="user_stringified_metadata" name="user[stringified_metadata]" rows="10" style="height: auto;"></textarea>)

      iex> ui_textarea(f, :address, hidden_label: true)
      ~s(<label for="user_address" class="o-visually-hidden">Metadata</label>
      <textarea id="user_address" name="user[address]"></textarea>)

  """
  def ui_textarea(form, field, opts \\ []) do
    opts = opts |> Keyword.put(:type, @input_mapping[:textarea])
    ui_input(form, field, opts)
  end

  @doc ~S"""
  Renders `<select>` elements, with the associated `<label>`s, and any errors for that field. As with the `select` form helper in `Phoenix.HTML.Form`, this expects the form, field, and options as first parameters.
  `opts` will be passed on to the respective underlying Phoenix form helper, with the following additional notes:

  `form` — the form object this input is being rendered inside
  `field` — the atom for the field you’re rendering
  `options` — the options to be rendered in this select element
  `opts[:e2e_classname]` — A classname that will be applied to the input for testing purposes, only on integration env
  `opts[:label]` — Override the default text to be used in the `<label>`

  ## Examples

    iex> ui_select(f, :week, 1..2, label: "Week", e2e_classname: "e2e-filters-week-week")
    ~s(<label for="filters_week">Week</label>
    <select class="e2e-filters-week-week" id="filters_week" name="filters[week]"><option value="1">1</option><option value="2">2</option></select>)

    iex> ui_select(f, :week, 1..2, label: "Week", hidden_label: true)
    ~s(<label for="filters_week" class="o-visually-hidden">Week</label>
    <select id="filters_week" name="filters[week]"><option value="1">1</option><option value="2">2</option></select>)

  """
  def ui_select(form, field, options, opts \\ []) do
    label_text = get_label(opts, field)
    label_opts = get_label_opts(opts)
    input_opts = get_input_opts(opts)

    error = Error.ui_error(form, field)
    input = Phoenix.HTML.Form.select(form, field, options, input_opts)

    [label(form, field, label_text, label_opts), input, error]
  end

  defp unwrapped_input(form, field, opts) do
    type = opts[:type]
    label_text = get_label(opts, field)
    label_opts = get_label_opts(opts)
    input_opts = get_input_opts(opts)

    error = Error.ui_error(form, field)
    input = render_input(type, form, field, input_opts)

    [label(form, field, label_text, label_opts), input, error]
  end

  defp wrapped_input(form, field, opts) do
    type = opts[:type]
    label_text = get_label(opts, field)
    input_opts = get_input_opts(opts)

    error = Error.ui_error(form, field)
    input = render_input(type, form, field, input_opts)

    label_tag =
      Phoenix.HTML.Form.label do
        [input, label_text]
      end

    [label_tag, error]
  end

  defp render_input(:radio_button, form, field, opts) do
    value = opts[:value]
    opts = opts |> Keyword.drop([:value])
    Phoenix.HTML.Form.radio_button(form, field, value, opts)
  end

  defp render_input(type, form, field, opts) do
    apply(Phoenix.HTML.Form, type, [form, field, opts])
  end

  defp get_label(opts, field) do
    opts[:label] || humanize(field)
  end

  defp get_label_opts(opts) do
    case opts[:hidden_label] do
      true -> opts |> Keyword.put(:class, classnames(["o-visually-hidden"]))
      false -> opts
      nil -> opts
    end
    |> Keyword.delete(:hidden_label)
  end

  defp get_input_opts(opts) do
    case classnames([opts[:e2e_classname]]) do
      "" -> opts
      cls -> opts |> Keyword.put(:class, cls)
    end
    |> Keyword.drop([:type, :label, :e2e_classname, :hidden_label])
  end

  defp put_type(opts) do
    type = Keyword.get(@input_mapping, opts[:type], @input_mapping[:text])
    opts |> Keyword.put(:type, type)
  end

  defp put_default_validations(opts) do
    if Enum.member?([:text_input, :email_input], opts[:type]) do
      opts |> Keyword.put_new(:maxlength, 255)
    else
      opts
    end
  end
end
