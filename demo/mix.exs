defmodule BitstylesPhoenixDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :bitstyles_phoenix_demo,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BitstylesPhoenixDemo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bitstyles_phoenix, path: '..'},
      {:faker, "~> 0.17"},
      {:ecto, "~> 3.7.1"},
      {:dart_sass, "~> 0.3", runtime: Mix.env() == :dev},
      {:phoenix, "~> 1.6.2"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.18.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:wallaby, "~> 0.29.0", runtime: false, only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: [
        "deps.get",
        "cmd (cd assets && npm install)"
      ],
      test: [
        "assets.compile",
        "test"
      ],
      bitstyles: [
        "cmd mkdir -p priv/static/assets",
        "cmd cp -R assets/node_modules/bitstyles/assets/* priv/static/assets",
        "cmd cp -R ../assets/logo.svg priv/static/assets/images/"
      ],
      "bitstyles.watch": [
        "bitstyles",
        "cmd fswatch -o assets/node_modules | xargs -n1 -I {} mix bitstyles"
      ],
      "assets.compile": [
        "esbuild default --minify",
        "sass default --no-source-map --style=compressed",
        "bitstyles"
      ],
      "assets.deploy": [
        "assets.compile",
        "phx.digest"
      ]
    ]
  end
end
