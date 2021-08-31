defmodule BitstylesPhoenix.Form do
  import BitstylesPhoenix.Classnames
  import BitstylesPhoenix.Showcase
  alias BitstylesPhoenix.Error
  import Phoenix.HTML, only: [sigil_E: 2]
  alias Phoenix.HTML.Form, as: PhxForm

  @moduledoc """
  Form-related UI components.
  The various form helpers here follow the interface provided by HTML — inputs, selects, and textareas.

  All helpers accept the following options:

  ## Options
  - `:label` — Override the default text to be used in the `<label>`
  - `:label_opts` — The options passed to the label element
  - `:hidden_label` — The label element will be visually hidden, but still present in the DOM
  - `:e2e_classname` — A classname that will be applied to the input for testing purposes, only on integration env
  """

  @input_mapping [
    color: :color_input,
    checkbox: :checkbox,
    date: :date_input,
    datetime: :datetime_input,
    email: :email_input,
    file: :file_input,
    number: :number_input,
    password: :password_input,
    radio: :radio_button,
    range: :range_input,
    search: :search_input,
    telephone: :telephone_input,
    text: :text_input,
    textarea: :textarea,
    time: :time_input,
    url: :url_input
  ]

  @doc ~S"""
  Renders all types of `<input>` element, with the associated `<label>`s, and any errors for that field. Defaults to `type="text"`, and `maxlength="255"`.
  As with the various `text_input`, `number_input` helpers in `Phoenix.HTML.Form`, this expects the form & field as first parameters.

  ## Options
  - `:type` — the type of the input (one of `:color`, `:checkbox`, `:date`, `:datetime`, `:email`, `:file`, `:number`, `:password`, `:radio`, `:range`, `:search`, `:telephone`, `:text`, `:textarea`, `:time`, `:url`)
  - All options from above (see top level module doc).
  - All other options will be passed to the underlying Phoenix form helper

  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--fieldset) for examples of inputs, selects, textareas, labels etc. in use.

  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-forms--login-form) for examples of form layouts.
  """

  story("Text field with label", """
      iex> safe_to_string ui_input(@user_form, :name)
      ~s(<label for="user_name">Name</label><input id="user_name" maxlength="255" name="user[name]" type="text">)
  """)

  story("Text field with error", """
      iex> safe_to_string ui_input(@error_form, :name)
      ~s(<label for="user_name">Name</label><input id="user_name" maxlength="255" name="user[name]" type="text"><span class="u-fg-warning" phx-feedback-for="user_name">is too short</span>)
  """)

  story("Text field with multiple errors", """
      iex> safe_to_string ui_input(@error_form, :email)
      ~s(<label for="user_email">Email</label><input id="user_email" maxlength="255" name="user[email]" type="text"><ul class=\"u-padding-l-left u-fg-warning\">
        <li><span class=\"u-fg-warning\" phx-feedback-for=\"user_email\">is invalid</span></li>
        <li><span class=\"u-fg-warning\" phx-feedback-for=\"user_email\">must end with @bitcrowd.net</span></li>
      </ul>
      )
  """)

  story("Text field with hidden label", """
      iex> safe_to_string ui_input(@user_form, :name, hidden_label: true)
      ~s(<label class="u-sr-only" for="user_name">Name</label><input id="user_name" maxlength="255" name="user[name]" type="text">)
  """)

  story("Text field with options", """
      iex> safe_to_string ui_input @user_form, :totp, label: "Authentication code", placeholder: "6-digit code", required: true, value: "", inputmode: "numeric", pattern: "[0-9]*", autocomplete: "one-time-code", maxlength: 6, label_opts: [class: "extra"]
      ~s(<label class="extra" for="user_totp">Authentication code</label><input autocomplete="one-time-code" id="user_totp" inputmode="numeric" maxlength="6" name="user[totp]" pattern="[0-9]*" placeholder="6-digit code" type="text" value="" required>)
  """)

  story("Email field with label", """
      iex> safe_to_string ui_input(@user_form, :email, type: :email)
      ~s(<label for="user_email">Email</label><input id="user_email" maxlength="255" name="user[email]" type="email">)
  """)

  story("Search field with placholder", """
      iex> safe_to_string ui_input(@user_form, :email_or_name, type: :search, placeholder: "Search by email or name", autofocus: true)
      ~s(<label for="user_email_or_name">Email or name</label><input id="user_email_or_name" name="user[email_or_name]" placeholder="Search by email or name" type="search" autofocus>)
  """)

  story("File field for pdfs", """
      iex> safe_to_string ui_input(@file_form, :file, type: :file, accept: "application/pdf")
      ~s(<label for="user_file">File</label><input accept="application/pdf" id="user_file" name="user[file]" type="file">)
  """)

  story("Checkbox", """
      iex> safe_to_string ui_input(@user_form, :accept, type: :checkbox)
      ~s(<label><input name="user[accept]" type="hidden" value="false"><input id="user_accept" name="user[accept]" type="checkbox" value="true">Accept</label>)
  """)

  story("Radio", """
      iex> safe_to_string ui_input(@user_form, :option, type: :radio, value: "one", label: "One")
      ~s(<label><input id="user_option_one" name="user[option]" type="radio" value="one">One</label>)
  """)

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
  Renders `<textarea>` elements, with the associated `<label>`s, and any errors for that field.
  This is a shortcut for `ui_input/3` with `type: :textarea`, accepting the same options as above.

  See the [bitstyles textarea docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--textarea-and-label) for examples of textareas and labels in use.
  """

  story("Textarea", """
      iex> safe_to_string ui_textarea(@user_form, :about_me)
      ~s(<label for="user_about_me">About me</label><textarea id="user_about_me" name="user[about_me]">
      </textarea>)
  """)

  story("Textarea with options", """
      iex> safe_to_string ui_textarea(@user_form, :metadata, label: "Metadata", value: "Value here", rows: 10, style: "height: auto;", label_opts: [class: "extra"])
      ~s(<label class="extra" for="user_metadata">Metadata</label><textarea id="user_metadata" name="user[metadata]" rows="10" style="height: auto;">
      Value here</textarea>)
  """)

  story("Textarea with hidden label", """
      iex> safe_to_string ui_textarea(@user_form, :address, hidden_label: true)
      ~s(<label class="u-sr-only" for="user_address">Address</label><textarea id="user_address" name="user[address]">
      </textarea>)
  """)

  def ui_textarea(form, field, opts \\ []) do
    opts = opts |> Keyword.put(:type, @input_mapping[:textarea])
    ui_input(form, field, opts)
  end

  @doc ~S"""
  Renders `<select>` elements, with the associated `<label>`s, and any errors for that field. Uses the `select` form helper in `Phoenix.HTML.Form`.

  ## Options
  - All options from above (see top level module doc).
  - All other options will be passed to the underlying Phoenix form helper

  See the [bitstyles select docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--select-and-label) for examples of textareas and labels in use.
  """

  story("Select box", """
      iex> safe_to_string ui_select(@user_form, :week, 1..2)
      ~s(<label for="user_week">Week</label><select id="user_week" name="user[week]"><option value="1">1</option><option value="2">2</option></select>)
  """)

  story("Select box without label", """
      iex> safe_to_string ui_select(@user_form, :week, 1..2, hidden_label: true)
      ~s(<label class="u-sr-only" for="user_week">Week</label><select id="user_week" name="user[week]"><option value="1">1</option><option value="2">2</option></select>)
  """)

  story("Select box with options", """
      iex> safe_to_string ui_select(@user_form, :preference, [{"Ducks", "ducks"}, {"Cats", "cats"}], label: "What do you like best?", label_opts: [class: "extra"])
      ~s(<label class=\"extra\" for="user_preference">What do you like best?</label><select id="user_preference" name="user[preference]"><option value="ducks">Ducks</option><option value="cats">Cats</option></select>)
  """)

  def ui_select(form, field, options, opts \\ []) do
    label_text = get_label(opts, field)
    label_opts = get_label_opts(opts)
    input_opts = get_input_opts(opts)

    label = PhxForm.label(form, field, label_text, label_opts)
    input = PhxForm.select(form, field, options, input_opts)
    errors = Error.ui_errors(form, field)

    ~E"<%= label %><%= input %><%= errors %>"
  end

  defp unwrapped_input(form, field, opts) do
    type = opts[:type]
    label_text = get_label(opts, field)
    label_opts = get_label_opts(opts)
    input_opts = get_input_opts(opts)

    label = PhxForm.label(form, field, label_text, label_opts)
    input = render_input(type, form, field, input_opts)
    errors = Error.ui_errors(form, field)

    ~E"<%= label %><%= input %><%= errors %>"
  end

  defp wrapped_input(form, field, opts) do
    type = opts[:type]
    label_text = get_label(opts, field)
    input_opts = get_input_opts(opts)

    errors = Error.ui_errors(form, field)
    input = render_input(type, form, field, input_opts)

    ~E"<%= PhxForm.label do %><%= input %><%= label_text %><% end %><%= errors %>"
  end

  defp render_input(:radio_button, form, field, opts) do
    value = opts[:value]
    opts = opts |> Keyword.drop([:value])
    PhxForm.radio_button(form, field, value, opts)
  end

  defp render_input(type, form, field, opts) do
    apply(PhxForm, type, [form, field, opts])
  end

  defp get_label(opts, field) do
    opts[:label] || PhxForm.humanize(field)
  end

  defp get_label_opts(opts) do
    label_opts = Keyword.get(opts, :label_opts, [])

    case opts[:hidden_label] do
      true -> label_opts |> Keyword.put(:class, classnames(["u-sr-only"]))
      _ -> label_opts
    end
  end

  defp get_input_opts(opts) do
    case classnames([opts[:e2e_classname]]) do
      "" -> opts
      cls -> opts |> Keyword.put(:class, cls)
    end
    |> Keyword.drop([:type, :label, :e2e_classname, :hidden_label, :label_opts])
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
