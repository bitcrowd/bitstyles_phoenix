import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bitstyles_phoenix_demo, BitstylesPhoenixDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "rWByyzlqZQabPuGKeXONbDeDQs8Zhgtgw9RALtnzQj1NZO51kFz8pvCsD42KXy3L",
  server: true

config :bitstyles_phoenix,
  trim_e2e_classes: [enabled: false]

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :wallaby, otp_app: :bitstyles_phoenix_demo
