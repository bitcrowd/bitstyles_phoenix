defmodule BitstylesPhoenix.MixProject do
  use Mix.Project

  def project do
    [
      app: :bitstyles_phoenix,
      version: "0.1.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A collection of Elixir phoenix helpers for bitstyles",
      licenses: ~w[ISC],
      source_url: "https://github.com/bitcrowd/bitstyles_phoenix"
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
      {:phoenix_html, "~> 2.14.3"}
    ]
  end
end
