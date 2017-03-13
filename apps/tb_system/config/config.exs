use Mix.Config

config :tb_system, [
  io: IO
]

import_config "#{Mix.env}.exs"
