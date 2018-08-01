defmodule Runnable do
  @moduledoc """
  Runnable is a sample Elixir application that can easily be run and
  act as an example on how to build different types of Elixir applications
  without using a framework such as Phoenix.
  """
  use Application
  alias Runnable.Greeting

  @doc """
  Start.

  Enables the application to run via `mix run` commands
  """
  def start(_type, _args) do
    Greeting.greet("Person")
    {:ok, self()}
  end
end
