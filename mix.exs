defmodule BitstylesPhoenix.MixProject do
  use Mix.Project

  def project do
    [
      app: :bitstyles_phoenix,
      version: "2.0.0",
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
        logo: "assets/logo.svg",
        extras: ["CHANGELOG.md", "README.md", "LICENSE.txt"],
        groups_for_modules: [
          Helpers: ~r/Helper/,
          Components: ~r/Component/,
          "Live components": ~r/Live/,
          "Alpine components": ~r/Alpine/
        ],
        nest_modules_by_prefix: [
          BitstylesPhoenix.Component,
          BitstylesPhoenix.Alpine3,
          BitstylesPhoenix.Live,
          BitstylesPhoenix.Helper
        ],
        before_closing_head_tag: &custom_css/1
      ]
    ]
  end

  def custom_css(:html), do: "<link rel=\"stylesheet\" href=\"assets/custom.css\">"
  def custom_css(_), do: ""

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
      {:phoenix_live_view, "~> 0.18.0"},
      {:floki, "~> 0.32.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: :dev, runtime: false}
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
