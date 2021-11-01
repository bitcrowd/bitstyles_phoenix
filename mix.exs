defmodule BitstylesPhoenix.MixProject do
  use Mix.Project

  def project do
    [
      app: :bitstyles_phoenix,
      version: "0.8.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A collection of Elixir phoenix helpers for bitstyles",
      package: package(),
      source_url: "https://github.com/bitcrowd/bitstyles_phoenix",
      docs: [
        main: "BitstylesPhoenix",
        assets: "assets",
        logo: "priv/logo.svg",
        extras: ["CHANGELOG.md", "README.md", "LICENSE.txt"],
        nest_modules_by_prefix: [
          BitstylesPhoenix.Component,
          BitstylesPhoenix.Helper
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]

  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:phoenix_live_view, "~> 0.17.0"},
      {:floki, "~> 0.32.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "bitstyles_phoenix",
      licenses: ~w[ISC],
      links: %{
        "GitHub" => "https://github.com/bitcrowd/bitstyles_phoenix",
        "bitstyles" => "https://github.com/bitcrowd/bitstyles"
      }
    ]
  end
end
