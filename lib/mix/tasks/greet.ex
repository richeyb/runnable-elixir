defmodule Mix.Tasks.Greet do
  use Mix.Task
  alias Runnable.Greeting

  @shortdoc "Runs our Greeting.greet/1 function"
  def run(_) do
    Application.ensure_started(:runnable)
    call_greeting()
  end

  defp call_greeting do
    Greeting.greet "Person"
  end
end