# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bitstyles_phoenix,
  translate_errors: {BitstylesPhoenixDemoWeb.ErrorHelpers, :translate_error, []},
  icon_file: {BitstylesPhoenixDemoWeb.Endpoint, :static_path, ["/assets/images/icons.svg"]}

config :bitstyles_phoenix_demo, BitstylesPhoenixDemoWeb.Gettext,
  default_locale: "en",
  locales: ~w(en de)

# Configures the endpoint
config :bitstyles_phoenix_demo, BitstylesPhoenixDemoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BitstylesPhoenixDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BitstylesPhoenixDemo.PubSub,
  live_view: [signing_salt: "38dJuqM3"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :dart_sass,
  version: "1.43.4",
  default: [
    args: ~w(css/app.scss ../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
