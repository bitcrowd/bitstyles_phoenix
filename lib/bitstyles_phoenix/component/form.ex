defmodule BitstylesPhoenix.Component.Form do
  use BitstylesPhoenix.Component

  import BitstylesPhoenix.Component.Error
  alias Phoenix.HTML.Form, as: PhxForm

  @moduledoc """
  Components for rendering input elements.

  Use `ui_input`, `ui_select`, `ui_textarea` to render the respective inputs together with a label and errors.
  Alternatively, this module also provides `input` and `label` functions that can be used to render only an input or only a label.

  ## Common attributes

  All `ui_*` components in this module accept the following attributes.

  - `form` *(required)* - The form to render the input form.
  - `field` *(required)* - The name of the field for the input.
  - `label` - The text to be used as label. Defaults to a title-cased name of the field.
  - `label_opts` - The options passed to the label element generated with `BitstylesPhoenix.Component.Form.label/1`.

  For details on how to render a form, see:
  - `simple_form` core component in a freshly-generated Phoenix app, or
  - `Phoenix.Component.form/1`, or
  - `Phoenix.HTML.Form.form_for/4` if using phoenix_html v3 or phoenix_html_helpers
  """

  @wrapper_assigns_keys [:field, :form, :label, :label_opts, :hidden_label]

  @doc """
  Renders various types of `<input>` element, with the associated `<label>`s, and any errors for that field.

  ## Attributes

  - `type` - The type of the input. Defaults to `type="text"`.
  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - All options from above (see top level module doc).
  - All other attributes will be passed onto the input element.
    Defaults to `maxlength="255"` for `email`, `text` and `password` type.
    Set maxlength to `false` to prevent setting maxlength.

  ## Types

  This function accepts all HTML input types, considering that:

  * `type="checkbox"` is used exclusively to render boolean values
  * For live file uploads, see `Phoenix.Component.live_file_input/1`

  See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
  for more information. Unsupported types, such as hidden and radio,
  are best written directly in your templates.

  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--fieldset) for examples of inputs, selects, textareas, labels etc. in use.
  See the [bitstyles form docs](https://bitcrowd.github.io/bitstyles/?path=/docs/ui-data-forms--login-form) for examples of form layouts.
  """

  story(
    "Text field with label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:name} />
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Name
        </label>
        <input id="user_name" name="user[name]" type="text" maxlength="255"/>
        """
    '''
  )

  story(
    "Text field with custom id with label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} id={"the_name"} field={:name} />
        ...> """
    ''',
    '''
        """
        <label for="the_name">
          Name
        </label>
        <input id="the_name" name="user[name]" type="text" maxlength="255"/>
        """
    '''
  )

  story(
    "Text required field with label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:name} required/>
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Name
          <span aria-hidden="true" class="u-fg-warning u-margin-xxs-left">
            *
          </span>
        </label>
        <input id="user_name" name="user[name]" type="text" maxlength="255" required="required"/>
        """
    '''
  )

  story(
    "Text field with error",
    '''
        iex> assigns=%{form: form_with_errors()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:name} />
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Name
        </label>
        <input id="user_name" name="user[name]" type="text" maxlength="255"/>
        <span class="u-fg-warning" phx-feedback-for="user[name]">
          is too short
        </span>
        """
    '''
  )

  story(
    "Text field with multiple errors",
    '''
        iex> assigns=%{form: form_with_errors()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:email} />
        ...> """
    ''',
    '''
        """
        <label for="user_email">
          Email
        </label>
        <input id="user_email" name="user[email]" type="text" maxlength="255"/>
        <ul class=\"u-padding-xl-left\">
          <li>
            <span class=\"u-fg-warning\" phx-feedback-for=\"user[email]\">
              is invalid
            </span>
          </li>
          <li>
            <span class=\"u-fg-warning\" phx-feedback-for=\"user[email]\">
              must end with @bitcrowd.net
            </span>
          </li>
        </ul>
        """
    '''
  )

  story(
    "Text field with hidden label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:name} hidden_label={true} />
        ...> """
    ''',
    '''
        """
        <label for="user_name" class="u-sr-only">
          Name
        </label>
        <input id="user_name" name="user[name]" type="text" maxlength="255"/>
        """
    '''
  )

  story(
    "Text field with label (without maxlength)",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:name} maxlength={false}/>
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Name
        </label>
        <input id="user_name" name="user[name]" type="text"/>
        """
    '''
  )

  story(
    "Text field with options",
    '''
        iex> assigns=%{form: form()}
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
    ''',
    '''
        """
        <label for="user_totp" class="extra">
          Authentication code
          <span aria-hidden="true" class="u-fg-warning u-margin-xxs-left">
            *
          </span>
        </label>
        <input id="user_totp" name="user[totp]" type="text" autocomplete="one-time-code" inputmode="numeric" maxlength="6" pattern="[0-9]*" placeholder="6-digit code" required="required" value=""/>
        """
    '''
  )

  story(
    "Email field with label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:email} type={:email} />
        ...> """
    ''',
    '''
        """
        <label for="user_email">
          Email
        </label>
        <input id="user_email" name="user[email]" type="email" maxlength="255"/>
        """
    '''
  )

  story(
    "Search field with placeholder",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input
        ...>    form={@form}
        ...>    field={:email_or_name}
        ...>    type={:search}
        ...>    placeholder="Search by email or name"
        ...>    autofocus={true} />
        ...> """
    ''',
    '''
        """
        <label for="user_email_or_name">
          Email or name
        </label>
        <input id="user_email_or_name" name="user[email_or_name]" type="search" autofocus="autofocus" placeholder="Search by email or name"/>
        """
    '''
  )

  story(
    "File field for pdfs",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <Phoenix.Component.form :let={form} for={@form} multipart>
        ...>   <.ui_input form={form} field={:file} type={:file} accept="application/pdf" />
        ...> </Phoenix.Component.form>
        ...> """
    ''',
    '''
        """
        <form enctype=\"multipart/form-data\">
          <label for="user_file">
            File
          </label>
          <input id="user_file" name="user[file]" type="file" accept="application/pdf"/>
        </form>
        """
    '''
  )

  story(
    "Checkbox",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:accept} type={:checkbox} />
        ...> """
    ''',
    '''
        """
        <label for="user_accept">
          <input name="user[accept]" type="hidden" value="false"/>
          <input id="user_accept" name="user[accept]" type="checkbox" value="true"/>
          Accept
        </label>
        """
    '''
  )

  story(
    "Checkbox required",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:accept} type={:checkbox} required/>
        ...> """
    ''',
    '''
        """
        <label for="user_accept">
          <input name="user[accept]" type="hidden" value="false"/>
          <input id="user_accept" name="user[accept]" type="checkbox" value="true" required="required"/>
          Accept
          <span aria-hidden="true" class="u-fg-warning u-margin-xxs-left">
            *
          </span>
        </label>
        """
    '''
  )

  story(
    "Checkbox with label class",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_input form={@form} field={:accept} type={:checkbox} label_opts={[class: "extra"]}/>
        ...> """
    ''',
    '''
        """
        <label for="user_accept" class="extra">
          <input name="user[accept]" type="hidden" value="false"/>
          <input id="user_accept" name="user[accept]" type="checkbox" value="true"/>
          Accept
        </label>
        """
    '''
  )

  def ui_input(assigns) do
    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys ++ [:type])

    assigns =
      assigns
      |> assign_new(:type, fn -> :text end)

    assigns =
      assigns
      |> assign(:extra, default_validations(extra, assigns.type))
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <%= if @type == :checkbox do %>
      <.ui_wrapped_input {@wrapper}>
        <.input field={@form[@field]} type={@type} {@extra} />
      </.ui_wrapped_input>
    <% else %>
      <.ui_unwrapped_input {@wrapper}>
        <.input field={@form[@field]} type={@type} {@extra} />
      </.ui_unwrapped_input>
    <% end %>
    """
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
  - All other attributes will be passed onto the textarea element.

  See the [bitstyles textarea docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--textarea-and-label) for examples of textareas and labels in use.
  """

  story(
    "Textarea",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_textarea form={@form} field={:about_me} />
        ...> """
    ''',
    '''
        """
        <label for="user_about_me">
          About me
        </label>
        <textarea id="user_about_me" name="user[about_me]">
        </textarea>
        """
    '''
  )

  story(
    "Textarea",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_textarea form={@form} field={:about_me} required/>
        ...> """
    ''',
    '''
        """
        <label for="user_about_me">
          About me
          <span aria-hidden="true" class="u-fg-warning u-margin-xxs-left">
            *
          </span>
        </label>
        <textarea id="user_about_me" name="user[about_me]" required="required">
        </textarea>
        """
    '''
  )

  story(
    "Textarea with options",
    '''
        iex> assigns=%{form: form()}
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
    ''',
    '''
        """
        <label for="user_metadata" class="extra">
          Metadata
        </label>
        <textarea id="user_metadata" name="user[metadata]" rows="10">
          Value here
        </textarea>
        """
    '''
  )

  story(
    "Textarea with hidden label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_textarea form={@form} field={:address} hidden_label/>
        ...> """
    ''',
    '''
        """
        <label for="user_address" class="u-sr-only">
          Address
        </label>
        <textarea id="user_address" name="user[address]">
        </textarea>
        """
    '''
  )

  story(
    "Textarea with error",
    '''
        iex> assigns=%{form: form_with_errors()}
        ...> render ~H"""
        ...> <.ui_textarea form={@form} field={:name} />
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Name
        </label>
        <textarea id="user_name" name="user[name]">
        </textarea>
        <span class="u-fg-warning" phx-feedback-for="user[name]">
          is too short
        </span>
        """
    '''
  )

  def ui_textarea(assigns) do
    assigns =
      assigns
      |> assign(:type, :textarea)

    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys ++ [:type])

    assigns =
      assigns
      |> assign(:extra, default_validations(extra, assigns.type))
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <.ui_unwrapped_input {@wrapper}>
      <.input field={@form[@field]} type={@type} {@extra} />
    </.ui_unwrapped_input>
    """
  end

  @doc ~S"""
  Renders a `<select>` element, with a `<label>` and any errors for that field.

  ## Attributes

  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - `options` - The options passed to `Phoenix.HTML.Form.options_for_select/2`.
  - `prompt` - Will be rendered as the first option with an empty value.
  - All options from above (see top level module doc).
  - All other attributes will be passed onto the select element.

  See the [bitstyles select docs](https://bitcrowd.github.io/bitstyles/?path=/docs/base-forms--select-and-label) for examples of selects and labels in use.
  """

  story(
    "Select box",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_select form={@form} field={:week} options={1..2} />
        ...> """
    ''',
    '''
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
    '''
  )

  story(
    "Select box required",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_select form={@form} field={:week} options={1..2} required />
        ...> """
    ''',
    '''
        """
        <label for="user_week">
          Week
          <span aria-hidden="true" class="u-fg-warning u-margin-xxs-left">
            *
          </span>
        </label>
        <select id="user_week" name="user[week]" required="required">
          <option value="1">
            1
          </option>
          <option value="2">
            2
          </option>
        </select>
        """
    '''
  )

  story(
    "Select box without label",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_select form={@form} field={:week} options={1..2} hidden_label/>
        ...> """
    ''',
    '''
        """
        <label for="user_week" class="u-sr-only">
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
    '''
  )

  story(
    "Select box with options",
    '''
        iex> assigns=%{form: form(), options: [{"Ducks", "ducks"}, {"Cats", "cats"}]}
        ...> render ~H"""
        ...> <.ui_select form={@form} field={:preference} options={@options} label="What do you like best?" label_opts={[class: "extra"]}/>
        ...> """
    ''',
    '''
        """
        <label for="user_preference" class="extra">
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
    '''
  )

  story(
    "Select box with prompt",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_select form={@form} field={:week} options={1..2} prompt={"Choose a week number"}/>
        ...> """
    ''',
    '''
        """
        <label for="user_week">
          Week
        </label>
        <select id="user_week" name="user[week]">
          <option value="">
            Choose a week number
          </option>
          <option value="1">
            1
          </option>
          <option value="2">
            2
          </option>
        </select>
        """
    '''
  )

  def ui_select(assigns) do
    assigns =
      assigns
      |> assign_new(:multiple, fn -> false end)
      |> assign_new(:prompt, fn -> nil end)
      |> assign(:type, :select)

    extra = assigns_to_attributes(assigns, @wrapper_assigns_keys ++ [:type])

    assigns =
      assigns
      |> assign(:extra, default_validations(extra, assigns.type))
      |> assign(:wrapper, wrapper_assigns(assigns))

    ~H"""
    <.ui_unwrapped_input {@wrapper}>
      <.input field={@form[@field]} type={:select} {@extra} />
    </.ui_unwrapped_input>
    """
  end

  defp wrapper_assigns(assigns) do
    Map.take(assigns, @wrapper_assigns_keys ++ [:required, :id])
  end

  @doc """
  Component for rendering custom inputs together with a label and errors.

  ## Attributes

  - `hidden_label` - Only show the label for screen readers if set to `true`.
  - All options from above (see top level module doc).
  """

  story(
    "Custom inputs",
    '''
        iex> assigns=%{form: form_with_errors()}
        ...> render ~H"""
        ...> <.ui_unwrapped_input form={@form} field={:name} label="Custom">
        ...>   Custom content
        ...>   <input type="text" whatever="foo" />
        ...> </.ui_unwrapped_input>
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          Custom
        </label>
        Custom content
        <input type="text" whatever="foo"/>
        <span class="u-fg-warning" phx-feedback-for="user[name]">
          is too short
        </span>
        """
    '''
  )

  def ui_unwrapped_input(assigns) do
    label_text = Map.get_lazy(assigns, :label, fn -> default_label(assigns.field) end)

    label_opts = assigns |> Map.get(:label_opts, [])

    label_opts =
      Keyword.put(
        label_opts,
        :class,
        classnames([label_opts[:class], {"u-sr-only", assigns[:hidden_label]}])
      )

    assigns =
      assigns
      |> assign_new(:id, fn -> default_id(assigns.form, assigns.field) end)
      |> assign(label_text: label_text, label_opts: label_opts)

    ~H"""
    <.label for={@id} {@label_opts} >
      <%= @label_text %>
      <.required_label {assigns_to_attributes(assigns)}/>
    </.label><%= render_slot(@inner_block) %>
    <.ui_errors form={@form} field={@field} />
    """
  end

  @doc """
  Component for rendering custom wrapped inputs in a label and with errors.

  ## Attributes

  - All options from above (see top level module doc).
  """

  story(
    "Custom wrapped inputs",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.ui_wrapped_input form={@form} field={:name} label="Current name">
        ...>   <input type="checkbox" id="user_name" whatever="foo" />
        ...> </.ui_wrapped_input>
        ...> """
    ''',
    '''
        """
        <label for="user_name">
          <input type="checkbox" id="user_name" whatever="foo"/>
          Current name
        </label>
        """
    '''
  )

  def ui_wrapped_input(assigns) do
    assigns =
      assigns
      |> assign_new(:id, fn -> default_id(assigns.form, assigns.field) end)
      |> assign_new(:label, fn -> default_label(assigns.field) end)
      |> assign_new(:label_opts, fn -> [] end)

    ~H"""
    <.label for={@id} {@label_opts} >
      <%= render_slot(@inner_block) %>
      <%= @label %>
      <.required_label {assigns_to_attributes(assigns)} />
    </.label>
    <.ui_errors form={@form} field={@field} />
    """
  end

  defp default_id(form, field) when is_atom(field), do: default_id(form, Atom.to_string(field))

  defp default_id(form, field) when is_binary(field) do
    PhxForm.input_id(form, field)
  end

  defp default_label(field) when is_atom(field), do: default_label(Atom.to_string(field))

  defp default_label(field) when is_binary(field) do
    bin =
      if String.ends_with?(field, "_id") do
        binary_part(field, 0, byte_size(field) - 3)
      else
        field
      end

    bin |> String.replace("_", " ") |> :string.titlecase()
  end

  defp required_label(%{required: value} = assigns)
       when value not in [nil, false, "false"] do
    {module, function, opts} =
      Application.get_env(:bitstyles_phoenix, :required_label, {
        __MODULE__,
        :default_required_label,
        []
      })

    assigns = assign(assigns, opts: opts)

    apply(module, function, [assigns])
  end

  defp required_label(assigns), do: ~H""

  @doc false
  def default_required_label(assigns) do
    ~H"""
    <span aria-hidden="true" class={classnames("u-fg-warning u-margin-xxs-left")}>*</span>
    """
  end

  @doc """
  Renders an input, select, or textarea.
  Direct usage is discouraged in favor of `ui_input` that comes with a label and errors.

  A `Phoenix.HTML.FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Types

  This function accepts all HTML input types, considering that:

  * You may also set `type="select"` to render a `<select>` tag
  * `type="checkbox"` is used exclusively to render boolean values
  * For live file uploads, see `Phoenix.Component.live_file_input/1`

  See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
  for more information. Unsupported types, such as hidden and radio,
  are best written directly in your templates.

  ## Attributes
  - `field` - a `Phoenix.HTML.FormField` struct retrieved from the form, for example: @form[:email]
  - `type` - string or atom, defaults to :text
  - `id` - string, required if `field` not passed
  - `name` - string, required if `field` not passed
  - `value` - any, required if `field` not passed
  - `checked` - boolean, required if `type="checkbox"`
  - `options` - list, required if `type="select"`
  - `multiple` - boolean, used if `type="select"`
  - `prompt` - string, used if `type="select"`
  - any other attributes, they will be passed to the input element
  """

  story(
    "Input (from field)",
    '''
        iex> assigns=%{form: form()}
        ...> render ~H"""
        ...> <.input field={@form[:name]} />
        ...> """
    ''',
    '''
        """
        <input id="user_name" name="user[name]" type="text"/>
        """
    '''
  )

  story(
    "Input (email)",
    '''
        iex> assigns=%{}
        ...> render ~H"""
        ...> <.input id="the_email" name="user[email]" type={:email} value="" class="foo bar"/>
        ...> """
    ''',
    '''
        """
        <input id="the_email" name="user[email]" type="email" class="foo bar" value=""/>
        """
    '''
  )

  story(
    "Input (checkbox)",
    '''
        iex> assigns=%{}
        ...> render ~H"""
        ...> <.input id="the_newsletter" name="user[wants_newsletter]" type={:checkbox} checked={false} data-theme="pink"/>
        ...> """
    ''',
    '''
        """
        <input name="user[wants_newsletter]" type="hidden" value="false"/>
        <input id="the_newsletter" name="user[wants_newsletter]" type="checkbox" value="true" data-theme="pink"/>
        """
    '''
  )

  story(
    "Input (select)",
    '''
        iex> assigns=%{}
        ...> render ~H"""
        ...> <.input id="the_day" name="user[dob_day]" type={:select} options={[{"Monday", 1},{"Tuesday", 2}]} value={2} prompt={"On which day were you born?"} data-foo=""/>
        ...> """
    ''',
    '''
        """
        <select id="the_day" name="user[dob_day]" data-foo="">
          <option value="">
            On which day were you born?
          </option>
          <option value="1">
            Monday
          </option>
          <option selected="selected" value="2">
            Tuesday
          </option>
        </select>
        """
    '''
  )

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil)
    |> assign_new(:id, fn -> field.id end)
    |> assign_new(:type, fn -> :text end)
    |> assign_new(:name, fn -> if assigns[:multiple], do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: type} = assigns) when is_atom(type) do
    input(%{assigns | type: Atom.to_string(type)})
  end

  def input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        PhxForm.normalize_value("checkbox", assigns[:value])
      end)

    extra = assigns_to_attributes(assigns, [:id, :name, :checked, :value, :type])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <input name={@name} type="hidden" value="false" disabled={@extra[:disabled]} />
    <input
      id={@id}
      name={@name}
      type="checkbox"
      value="true"
      checked={@checked}
      {@extra}
    />
    """
  end

  def input(%{type: "select"} = assigns) do
    assigns =
      assigns
      |> assign_new(:prompt, fn -> nil end)
      |> assign_new(:multiple, fn -> false end)

    extra =
      assigns_to_attributes(assigns, [:id, :name, :type, :multiple, :prompt, :options, :value])

    assigns = assign(assigns, extra: extra)

    ~H"""
    <select
      id={@id}
      name={@name}
      multiple={@multiple}
      {@extra}
    >
      <option :if={@prompt} value=""><%= @prompt %></option>
      <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
    </select>
    """
  end

  def input(%{type: "textarea"} = assigns) do
    extra = assigns_to_attributes(assigns, [:id, :name, :type, :value])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <textarea
      id={@id}
      name={@name}
      {@extra}
    ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def input(assigns) do
    extra = assigns_to_attributes(assigns, [:id, :name, :type, :value])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <input
      id={@id}
      name={@name}
      type={@type}
      {@extra}
      value={Phoenix.HTML.Form.normalize_value(@type, @value)}
    />
    """
  end

  @doc """
  Renders a label. Direct usage is discouraged in favor of `ui_input` that comes with a label.

  ## Attributes

  - `for` - id of the input the label belongs to.
  """

  story(
    "Label",
    '''
        iex> assigns=%{}
        ...> render ~H"""
        ...> <.label for="user_address_city" class="foo bar">
        ...>   City
        ...> </.label>
        ...> """
    ''',
    '''
        """
        <label for="user_address_city" class="foo bar">
          City
        </label>
        """
    '''
  )

  story(
    "Label (no for)",
    '''
        iex> assigns=%{}
        ...> render ~H"""
        ...> <.label class="foo bar">
        ...>   Note
        ...>   <input type="text" name="note"/>
        ...> </.label>
        ...> """
    ''',
    '''
        """
        <label class="foo bar">
          Note
          <input type="text" name="note"/>
        </label>
        """
    '''
  )

  def label(assigns) do
    assigns =
      assigns
      |> assign_new(:for, fn -> nil end)

    extra = assigns_to_attributes(assigns, [:for])
    assigns = assign(assigns, extra: extra)

    ~H"""
    <label for={@for} {@extra}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
