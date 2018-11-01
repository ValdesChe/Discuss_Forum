# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7m71s0PpicVZGncI1nRjVswobhFiaUanAt5lDKBXCK6yBKJKJJupH/obzeP1DotU",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  # Here our client_id and client_secret key
  client_id: "495e94d4437645d93935",
  client_secret: "c6106ca7c8360e97b3ed68f23bd70ff593c9b0ac"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
