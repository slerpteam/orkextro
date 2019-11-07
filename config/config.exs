# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :orkextro, username: System.get_env("ORKEXTRO_USERNAME")
config :orkextro, password: System.get_env("ORKEXTRO_PASSWORD")
config :orkextro, api_key: System.get_env("ORKEXTRO_API_KEY")
config :orkextro, api: Orkextro.Request

import_config "#{Mix.env()}.exs"
