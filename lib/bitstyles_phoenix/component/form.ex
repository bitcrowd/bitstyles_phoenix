defmodule BitstylesPhoenix.Component.Form do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Error
  alias Phoenix.HTML.Form, as: PhxForm

  @moduledoc """
  Components for rendering input elements.

  ## Common attributes

  All helpers in this module accept the following attributes.

  - `form` *(required)* - The form to render the input form.
  - `field` *(required)* - The name of the field for the input.
  - `label` - The text to be used as label. Defaults to `Phoenix.HTML.Form.humanize/1`.
  - `label_opts` - The options passed to the label element generated with `Phoenix.HTML.Form.label/4`.

  See `Phoenix.HTML.Form.form_for/4` or LiveView `form` component for details on how to render a form.
  """

  @input_mapping %{
    color: :color_input,
    checkbox: :checkbox,
    date: :date_input,
    datetime_local: :datetime_local_input,
    email: :email_input,
    file: :file_input,
    number: :number_input,
    password: :password_input,
    range: :range_input,
    search: :search_input,
    telephone: :telephone_input,
    text: :text_input,
    time: :time_input,
    url: :url_input
  }

  @wrapper_assigns_keys [:field, :form, :label, :label_opts, :hidden_label]

  @type_doc_table @input_mapping
                  |> Enum.map(fn {type, helper} ->
                    "| `:#{type}` | `Phoenix.HTML.Form.#{helper}/3` |\n"
                  end)

  @doc """
  Renders various types of `<input>` element, with the associated `<label>`s, and any errors for that field.

  ## Attributes

  - `type` - The type of the input (see table below for available types). Defaults to `type="text"`.
  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - All options from above (see top level module doc).
  - All other attributes will be passed in as input options to the underlying input
    helpers from `Phoenix.HTML.Form` (see table below for used helpers).
    Defaults to `maxlength="255"` for `email`, `text` and `password` type.
    Set maxlength to `false` to prevent setting maxlength.

  For reference which input helper is used check out the following mapping:

  | type | Helper |
  | :--: | ------ |
  #{@type_doc_table}

  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--fieldset) for examples of inputs, selects, textareas, labels etc. in use.
  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-forms--login-form) for examples of form layouts.
  """

  story("Text field with label", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:name} />
      ...> """
      """
      <label for="user_name">
        Name
      </label>
      <input id="user_name" maxlength="255" name="user[name]" type="text"/>
      """
  ''')

  story("Text field with error", '''
      iex> assigns=%{form: @error_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:name} />
      ...> """
      """
      <label for="user_name">
        Name
      </label>
      <input id="user_name" maxlength="255" name="user[name]" type="text"/>
      <span class="u-fg--warning" phx-feedback-for="user[name]">
        is too short
      </span>
      """
  ''')

  story("Text field with multiple errors", '''
      iex> assigns=%{form: @error_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:email} />
      ...> """
      """
      <label for="user_email">
        Email
      </label>
      <input id="user_email" maxlength="255" name="user[email]" type="text"/>
      <ul class=\"u-padding-xl-left\">
        <li>
          <span class=\"u-fg--warning\" phx-feedback-for=\"user[email]\">
            is invalid
          </span>
        </li>
        <li>
          <span class=\"u-fg--warning\" phx-feedback-for=\"user[email]\">
            must end with @bitcrowd.net
          </span>
        </li>
      </ul>
      """
  ''')

  story("Text field with hidden label", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:name} hidden_label={true} />
      ...> """
      """
      <label class="u-sr-only" for="user_name">
        Name
      </label>
      <input id="user_name" maxlength="255" name="user[name]" type="text"/>
      """
  ''')

  story("Text field with label (without maxlength)", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:name} maxlength={false}/>
      ...> """
      """
      <label for="user_name">
        Name
      </label>
      <input id="user_name" name="user[name]" type="text"/>
      """
  ''')

  story("Text field with options", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input
      ...>   form={@form}
      ...>   field={:totp}
      ...>   label="Authentication code"
      ...>   label_opts={[class: "extra"]}
      ...>   placeholder="6-digit code"
      ...>   required={true}
      ...>   value=""
      ...>   inputmode="numeric"
      ...>   pattern="[0-9]*"
      ...>   autocomplete="one-time-code"
      ...>   maxlength={6} />
      ...> """
      """
      <label class="extra" for="user_totp">
        Authentication code
      </label>
      <input autocomplete="one-time-code" id="user_totp" inputmode="numeric" maxlength="6" name="user[totp]" pattern="[0-9]*" placeholder="6-digit code" required="required" type="text" value=""/>
      """
  ''')

  story("Email field with label", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:email} type={:email} />
      ...> """
      """
      <label for="user_email">
        Email
      </label>
      <input id="user_email" maxlength="255" name="user[email]" type="email"/>
      """
  ''')

  story("Search field with placholder", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input
      ...>    form={@form}
      ...>    field={:email_or_name}
      ...>    type={:search}
      ...>    placeholder="Search by email or name"
      ...>    autofocus={true} />
      ...> """
      """
      <label for="user_email_or_name">
        Email or name
      </label>
      <input autofocus="autofocus" id="user_email_or_name" name="user[email_or_name]" placeholder="Search by email or name" type="search"/>
      """
  ''')

  story("File field for pdfs", '''
      iex> assigns=%{form: @file_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:file} type={:file} accept="application/pdf" />
      ...> """
      """
      <label for="user_file">
        File
      </label>
      <input accept="application/pdf" id="user_file" name="user[file]" type="file"/>
      """
  ''')

  story("Checkbox", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:accept} type={:checkbox} />
      ...> """
      """
      <label for="user_accept">
        <input name="user[accept]" type="hidden" value="false"/>
        <input id="user_accept" name="user[accept]" type="checkbox" value="true"/>
        Accept
      </label>
      """
  ''')

  story("Checkbox with label class", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_input form={@form} field={:accept} type={:checkbox} label_opts={[class: "extra"]}/>
      ...> """
      """
      <label class="extra" for="user_accept">
        <input name="user[accept]" type="hidden" value="false"/>
        <input id="user_accept" name="user[accept]" type="checkbox" value="true"/>
        Accept
      </label>
      """
  ''')

  def ui_input(assigns) do
    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys ++ [:type])

    assigns =
      assigns
      |> assign_new(:type, fn -> :text end)
      |> assign(:extra, extra)
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <%= if @type == :checkbox do %>
      <.ui_wrapped_input {@wrapper}>
        <%= render_input(:checkbox, @form, @field, @extra) %>
      </.ui_wrapped_input>
    <% else %>
      <.ui_unwrapped_input {@wrapper}>
        <%= render_input(@type, @form, @field, @extra) %>
      </.ui_unwrapped_input>
    <% end %>
    """
  end

  defp render_input(type, form, field, opts) do
    apply(PhxForm, input_type(type), [form, field, default_validations(opts, type)])
  end

  defp input_type(type) do
    Map.get(@input_mapping, type, :text_input)
  end

  defp default_validations(extra, type) when type in [:email, :text, :password] do
    Keyword.put_new(extra, :maxlength, 255)
  end

  defp default_validations(extra, _), do: extra

  @doc ~S"""
  Renders `<textarea>` elements, with the associated `<label>`s, and any errors for that field.

  ## Attributes

  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - All options from above (see top level module doc).
  - All other attributes will be passed in as input options to `Phoenix.HTML.Form.textarea/3`.

  See the [bitstyles textarea docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--textarea-and-label) for examples of textareas and labels in use.
  """

  story("Textarea", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_textarea form={@form} field={:about_me} />
      ...> """
      """
      <label for="user_about_me">
        About me
      </label>
      <textarea id="user_about_me" name="user[about_me]">
      </textarea>
      """
  ''')

  story("Textarea with options", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_textarea
      ...>   form={@form}
      ...>   field={:metadata}
      ...>   label="Metadata"
      ...>   label_opts={[class: "extra"]}
      ...>   value="Value here"
      ...>   rows={10}
      ...> />
      ...> """
      """
      <label class="extra" for="user_metadata">
        Metadata
      </label>
      <textarea id="user_metadata" name="user[metadata]" rows="10">
        Value here
      </textarea>
      """
  ''')

  story("Textarea with hidden label", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_textarea form={@form} field={:address} hidden_label/>
      ...> """
      """
      <label class="u-sr-only" for="user_address">
        Address
      </label>
      <textarea id="user_address" name="user[address]">
      </textarea>
      """
  ''')

  story("Textarea with error", '''
      iex> assigns=%{form: @error_form}
      ...> render ~H"""
      ...> <.ui_textarea form={@form} field={:name} />
      ...> """
      """
      <label for="user_name">
        Name
      </label>
      <textarea id="user_name" name="user[name]">
      </textarea>
      <span class="u-fg--warning" phx-feedback-for="user[name]">
        is too short
      </span>
      """
  ''')

  def ui_textarea(assigns) do
    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys)

    assigns =
      assigns
      |> assign(:extra, extra)
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <.ui_unwrapped_input {@wrapper}>
      <%= PhxForm.textarea(@form, @field, @extra) %>
    </.ui_unwrapped_input>
    """
  end

  @doc ~S"""
  Renders a `<select>` element, with a `<label>` and any errors for that field.

  ## Attributes

  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - `options` - The options passed to `Phoenix.HTML.Form.select/4`.
  - All options from above (see top level module doc).
  - All other attributes will be passed in as input options to `Phoenix.HTML.Form.select/4`.

  See the [bitstyles select docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--select-and-label) for examples of textareas and labels in use.
  """

  story("Select box", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_select form={@form} field={:week} options={1..2} />
      ...> """
      """
      <label for="user_week">
        Week
      </label>
      <select id="user_week" name="user[week]">
        <option value="1">
          1
        </option>
        <option value="2">
          2
        </option>
      </select>
      """
  ''')

  story("Select box without label", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_select form={@form} field={:week} options={1..2} hidden_label/>
      ...> """
      """
      <label class="u-sr-only" for="user_week">
        Week
      </label>
      <select id="user_week" name="user[week]">
        <option value="1">
          1
        </option>
        <option value="2">
          2
        </option>
      </select>
      """
  ''')

  story("Select box with options", '''
      iex> assigns=%{form: @user_form, options: [{"Ducks", "ducks"}, {"Cats", "cats"}]}
      ...> render ~H"""
      ...> <.ui_select form={@form} field={:preference} options={@options} label="What do you like best?" label_opts={[class: "extra"]}/>
      ...> """
      """
      <label class="extra" for="user_preference">
        What do you like best?
      </label>
      <select id="user_preference" name="user[preference]">
        <option value="ducks">
          Ducks
        </option>
        <option value="cats">
          Cats
        </option>
      </select>
      """
  ''')

  def ui_select(assigns) do
    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys ++ [:options])

    assigns =
      assigns
      |> assign(:extra, extra)
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <.ui_unwrapped_input {@wrapper}>
      <%= PhxForm.select(@form, @field, @options, @extra) %>
    </.ui_unwrapped_input>
    """
  end

  defp wrapper_assigns(assigns) do
    Map.take(assigns, @wrapper_assigns_keys)
  end

  @doc """
  Component for rendering custom inputs together with a label and errors.

  ## Attributes

  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - All options from above (see top level module doc).
  """

  story("Custom inputs", '''
      iex> assigns=%{form: @error_form}
      ...> render ~H"""
      ...> <.ui_unwrapped_input form={@form} field={:name} label="Custom">
      ...>   Custom content
      ...>   <input type="text" whatever="foo" />
      ...> </.ui_unwrapped_input>
      ...> """
      """
      <label for="user_name">
        Custom
      </label>
      Custom content
      <input type="text" whatever="foo"/>
      <span class="u-fg--warning" phx-feedback-for="user[name]">
        is too short
      </span>
      """
  ''')

  def ui_unwrapped_input(assigns) do
    label_text = Map.get_lazy(assigns, :label, fn -> default_label(assigns.field) end)

    label_opts = assigns |> Map.get(:label_opts, [])

    label_opts =
      Keyword.put(
        label_opts,
        :class,
        classnames([label_opts[:class], {"u-sr-only", assigns[:hidden_label]}])
      )

    label = PhxForm.label(assigns.form, assigns.field, label_text, label_opts)

    assigns = assign(assigns, :label, label)

    ~H"""
    <%= @label %><%= render_slot(@inner_block) %><.ui_errors form={@form} field={@field} />
    """
  end

  @doc """
  Component for rendering custom wrapped inputs in a label and with errors.

  ## Attributes

  - All options from above (see top level module doc).
  """

  story("Custom wrapped inputs", '''
      iex> assigns=%{form: @user_form}
      ...> render ~H"""
      ...> <.ui_wrapped_input form={@form} field={:name} label="Current name">
      ...>   <input type="checkbox" id="user_name" whatever="foo" />
      ...> </.ui_wrapped_input>
      ...> """
      """
      <label for="user_name">
        <input type="checkbox" id="user_name" whatever="foo"/>
        Current name
      </label>
      """
  ''')

  def ui_wrapped_input(assigns) do
    assigns =
      assigns
      |> assign_new(:label, fn -> default_label(assigns.field) end)
      |> assign_new(:label_opts, fn -> [] end)

    ~H"""
    <%= PhxForm.label @form, @field, @label_opts do %>
      <%= render_slot(@inner_block) %>
      <%= @label %>
    <% end %>
    <.ui_errors form={@form} field={@field} />
    """
  end

  defp default_label(field), do: PhxForm.humanize(field)
end
