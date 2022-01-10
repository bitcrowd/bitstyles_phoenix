# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bitstyles_phoenix,
  bitstyles_version: "3.1.0",
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

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
