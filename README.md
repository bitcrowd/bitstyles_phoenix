# BitstylesPhoenix

[![Hex pm](http://img.shields.io/hexpm/v/bitstyles_phoenix.svg?style=flat)](https://hex.pm/packages/bitstyles_phoenix)
[![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/bitstyles_phoenix)
[![License](https://img.shields.io/hexpm/l/bitstyles_phoenix?style=flat)](LICENSE)
[![CircleCI](https://circleci.com/gh/bitcrowd/bitstyles_phoenix.svg?style=shield)](https://circleci.com/gh/bitcrowd/bitstyles_phoenix)

Basic helpers for [bitstyles](https://github.com/bitcrowd/bitstyles) for elixir phoenix projects.
Currently made for version 1.0.2 of bitstyles. Future versions might still work, since 
the common interface is just CSS classes. Feel free to drop PRs if you notice any inconsistencies with new versions.

## Requirements 

bitstyles must be installed separately into the asset generation. The helpers in this project just output classes for working with bitstyles.

## Installation

The package can be installed by adding `bitstyles_phoenix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bitstyles_phoenix, "~> 0.1.0"}
  ]
end
```

To make use of the various `ui_*` helpers in the project, just add a use statement to the phoenix application view_helpers: 

``` elixir
  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      use BitstylesPhoenix.Components

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      ...
    end
  end

```

## Configuration

If you want to stop bitstyles_phoenix from removing e2e classes (e.g. in e2e tests) use this config:

``` elixir
config :bitstyles_phoenix, :trim_e2e_classes, true
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bitstyles_phoenix](https://hexdocs.pm/bitstyles_phoenix).
