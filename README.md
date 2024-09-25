# BitstylesPhoenix

[![Hex pm](http://img.shields.io/hexpm/v/bitstyles_phoenix.svg?style=flat)](https://hex.pm/packages/bitstyles_phoenix)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/bitstyles_phoenix)
[![License](https://img.shields.io/hexpm/l/bitstyles_phoenix?style=flat)](./LICENSE.txt)

Basic helpers for [bitstyles](https://github.com/bitcrowd/bitstyles) for elixir phoenix projects.

## Requirements

Bitstyles must be installed separately into the asset generation. The helpers in this project just output classes for working with bitstyles.

Bitstyles versions from 6.0.0 down to 1.3.0 are supported.

## Installation

The package can be installed by adding `bitstyles_phoenix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bitstyles_phoenix, "~> 2.5"}
  ]
end
```

To make use of the various `ui_*` helpers in the project, just add a use statement to the phoenix application view_helpers:

```elixir
  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      use BitstylesPhoenix

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      ...
    end
  end

```

## Getting started

Check out the top level `BitstylesPhoenix` module for usage examples, for the `ui_*` helpers.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bitstyles_phoenix](https://hexdocs.pm/bitstyles_phoenix).

## Configuration

Check out the top level `BitstylesPhoenix` module for configuration examples and documentation.

## Developing bitstyles_phoenix

To live update the documentation when you change the `lib` folder you can do:

```sh
mix docs && fswatch -o lib | xargs -n1 -I {} mix docs
```

For running the demo app & integration tests check out the [demo README](demo/README.md).
