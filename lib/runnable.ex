defmodule Runnable do
  @moduledoc """
  Runnable is a sample Elixir application that can easily be run and
  act as an example on how to build different types of Elixir applications
  without using a framework such as Phoenix.
  """
  use Application
  alias Runnable.Greeting

  require Logger

  @doc """
  Start.

  Enables the application to run via `mix run` commands
  """
  def start(_type, _args) do
    log()

    children = [
      Greeting
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp log do
    Logger.metadata(request_id: "ABCDEF")
    Logger.debug "Starting Application..."
    Logger.info "I should get output twice"
  end
end
