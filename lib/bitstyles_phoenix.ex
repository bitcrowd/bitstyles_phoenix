defmodule BitstylesPhoenix do
  @moduledoc """
  Documentation for BitstylesPhoenix.

  ## Setup & Getting started

  Check out the main [README](README.md).

  ## Usage

  Use by either `use BitstylesPhoenix` or importing the components and helpers individually.

  ```elixir
    use BitstylesPhoenix

    # or

    import BitstylesPhoenix.Helper.Button
  ```

  Then use the components and helpers in your `*.heex` templates:

  ```elixir
  <.ui_badge>A nice badge</.ui_badge>
  # => <span class="a-badge u-h6 u-font-medium a-badge--text">A nice badge</span>
  ```

  ```elixir
  ui_button("Save", type: "submit")
  # => <button class="a-button" type="submit">Save</button>
  ```

  Some components require additional JS to work as intended. Either you implement the JS yourself
  and use the ui components directly, or the `Live` or `Alpine3` ones.
  ```
    use BitstylesPhoenix.Live    # import all `BitstylesPhoenix.Live` components
    use BitstylesPhoenix.Alpine3 # import all `BitstylesPhoenix.Alpine3` components
  ```

  For the Alpine versions to work, [alpine.js](https://alpinejs.dev/) should be present on the page.
  The [JS commands](https://hexdocs.pm/phoenix_live_view/bindings.html#js-commands) version will only work within connected LiveViews.

  Checkout the components and helpers for examples and showcases.

  ## Configuration

  The library can be configured through `mix` configuration.

  ### Bitstyles version

  BitstylesPhoenix will generate classes #{BitstylesPhoenix.Bitstyles.Version.version_string()} of bitstyles.
  You can set older versions with a configuration:

  ```elixir
  config :bitstyles_phoenix,
    bitstyles_version: "1.5.0"
  ```
  Release candidate versions are currently not supported.

  ### Translating error messages

  Generated phoenix apps usually come with a helper for [translating error messages](https://github.com/phoenixframework/phoenix/blob/496123b66c03c9764be623d2c32b4af611837eb0/installer/templates/phx_web/views/error_helpers.ex#L23-L46)
  using `gettext`. This helper can be used to translate error messages rendered with `bitstyles_phoenix`.

  In order to do so you can configure the generated helper or write your own with the MFA configuration.

  ```elixir
  config :bitstyles_phoenix,
    translate_errors: {ExampleWeb.ErrorHelpers, :translate_error, []}
  ```

  ### Icon file

  In order for the bitstyles icons to properly render they can either be rendered inline in the document or served as an SVG file
  and configured with the phoenix static_path helpers. The configured icon file path can be either a string or a MF/MFA.

  Example:
  ```
  config :bitstyles_phoenix,
    icon_file: {MyappWeb.Endpoint, :static_path, ["/assets/images/icons.svg"]}
  ```

  In order for the above example to work, one has to serve the bitstyles icon file under that static path.
  This can be done either via a webpack file-loader, postcss or simply by copying the files into the `priv/static` dir of
  your phoenix app.

  Check out the [demo project](#{Mix.Project.config()[:source_url]}/tree/main/demo) folder in the sources
  for an example configuration.

  ### Trim `e2e-` classnames

  Sometimes you need to set classes for testing, that are not needed or used in production.
  By default, all classes generated by bitstyles_phoenix are appended using `BitstylesPhoenix.Helper.Classnames.classnames/1`.
  This helper trims classes prefixed with `e2e` by default. This behaviour can be configured:

  Disable trimming
  ```elixir
  config :bitstyles_phoenix,
    trim_e2e_classes: [enabled: false]
  ```

  Use another prefix for trimming
  ```elixir
  config :bitstyles_phoenix,
    trim_e2e_classes: [enabled: true, prefix: "test-"]
  ```

  ### Defining a required label

  You can control how required labels are rendered. By default you will get this appended to your labels if the input is required:
  ```html
    <span aria-hidden="true" class="u-fg-warning u-margin-s4s-left">*</span>
  ```

  You can override it by specifying your own component to render the required labels. The component will get the form and the field as assigns, as well as any optional parameters you pass in the MFA as `@opts`.

  ```elixir
  config :bitstyles_phoenix,
    required_label: {MyComponent, :my_required_label, []}

  defmodule MyComponent do
    use Phoenix.Component

    def my_required_label(assigns) do
      ~H"<span>(required)</span>"
    end
  end
  ```

  """

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Component.Avatar
      import BitstylesPhoenix.Component.Badge
      import BitstylesPhoenix.Component.Breadcrumbs
      import BitstylesPhoenix.Component.Button
      import BitstylesPhoenix.Component.Card
      import BitstylesPhoenix.Component.Content
      import BitstylesPhoenix.Component.DescriptionList
      import BitstylesPhoenix.Component.Dropdown
      import BitstylesPhoenix.Component.Error
      import BitstylesPhoenix.Component.Flash
      import BitstylesPhoenix.Component.Form
      import BitstylesPhoenix.Component.Heading
      import BitstylesPhoenix.Component.Icon
      import BitstylesPhoenix.Component.Modal
      import BitstylesPhoenix.Component.Sidebar
      import BitstylesPhoenix.Component.Tabs
      import BitstylesPhoenix.Component.UseSVG

      import BitstylesPhoenix.Helper.Classnames
    end
  end
end
