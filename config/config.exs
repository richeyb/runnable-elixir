use Mix.Config

# Our Logger general configuration
config :logger,
  backends: [
    :console,
    {Runnable.LogBackend, :log_backend}
  ],
  level: :debug,
  compile_time_purge_level: :debug

# Our Console Backend-specific configuration
config :logger, :console,
  format: {Runnable.LogFormatter, :format},
  metadata: [:request_id]

config :logger, :log_backend,
    level: :info
# import_config "#{Mix.env}.exs"