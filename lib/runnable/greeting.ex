defmodule Runnable.Greeting do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def greet(name) do
    GenServer.call(__MODULE__, {:greet, name})
  end

  # ----------------

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:greet, name}, _from, state) do
    do_greeting(name)
    {:reply, :ok, state}
  end

  defp do_greeting(name) do
    IO.puts "Hello, #{name}"
  end
end