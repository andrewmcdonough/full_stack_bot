# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :bot_engine, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:bot_engine, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#

if Mix.env == :test do
  config :exvcr, [
    vcr_cassette_library_dir: "fixture/vcr_cassettes",
    filter_sensitive_data: [
      [pattern: "Bearer .*$", placeholder: "API_AI_CLIENT_TOKEN"]
    ],
    filter_url_params: false,
    response_headers_blacklist: []
  ]
end

config :bot_engine, BotEngine.ApiAi,
  client_access_token: System.get_env("API_AI_CLIENT_ACCESS_TOKEN")
