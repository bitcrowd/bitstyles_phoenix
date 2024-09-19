import Config

config :bitstyles_phoenix,
  trim_e2e_classes: [enabled: true]

config :phoenix, :json_library, Jason

if config_env() === :test do
  config :bitstyles_phoenix, add_version_test_classes: true
end
