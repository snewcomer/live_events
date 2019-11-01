# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_events,
  ecto_repos: [LiveEvents.Repo]

# Configures the endpoint
config :live_events, LiveEventsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "esI2pxESSsMyaFF6nBR3klV/fMy5SOevpm3h0JUo4gmnaRTv2a8z6n1le4XIV3fb",
  render_errors: [view: LiveEventsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveEvents.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :live_events, LiveEventsWeb.Endpoint,
   live_view: [
     signing_salt: "jYQt2xVm3qRcOHAAPeboJ7JJajx7Tq7t"
   ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
