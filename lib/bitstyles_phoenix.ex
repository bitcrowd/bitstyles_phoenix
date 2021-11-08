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
  # => <span class="a-badge u-h6 u-font--medium a-badge--gray">A nice badge</span>
  ```

  ```elixir
  ui_button("Save", type: "submit")
  # => <button class="a-button" type="submit">Save</button>
  ```

  Checkout the components and helpers for examples and showcases.

  ## Configuration

  The library can be configured through `mix` configuration.

  ### Bitstyles version

  BitstylesPhoenix will generate classes #{BitstylesPhoenix.Bitstyles.version()} of bitstyles.
  You can set older versions with a configuration:

  ```elixir
  config :bitstyles_phoenix,
    bitstyles_version: "1.5.0"
  ```
  Release candidate versions are currently not supported.

  ### Translating error messages

  Generated phoenix apps usally come with a helper for [translating error messages](https://github.com/phoenixframework/phoenix/blob/496123b66c03c9764be623d2c32b4af611837eb0/installer/templates/phx_web/views/error_helpers.ex#L23-L46)
  using `gettext`. This helper can be used to translate error messages rendered with `bitstyles_phoenix`.

  In order to do so you can configure the generated helper or write your own with the MFA configuration.

  ```elixir
  config :bitstyles_phoenix,
    translate_errors: {ExampleWeb.ErrorHelper, :translate_errors, []}
  ```

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
  """

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Component.Badge
      import BitstylesPhoenix.Component.Flash
      import BitstylesPhoenix.Component.Icon
      import BitstylesPhoenix.Component.UseSVG
      import BitstylesPhoenix.Component.Error
      import BitstylesPhoenix.Component.Form

      import BitstylesPhoenix.Helper.Button
      import BitstylesPhoenix.Helper.Classnames
    end
  end
end
