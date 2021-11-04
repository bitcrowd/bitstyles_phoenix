import Config

config :bitstyles_phoenix,
  trim_e2e_classes: [enabled: true],
  bitstyles_default_version: "2.0.0",
  bitstyles_cdn: "https://cdn.jsdelivr.net/npm/bitstyles"

config :phoenix, :json_library, Jason
