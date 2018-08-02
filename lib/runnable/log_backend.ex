defmodule Runnable.LogBackend do
  # Initialize the configuration
  def init({__MODULE__, name}) do
    {:ok, configure(name, [])}
  end

  # Handle the configuration change call
  def handle_call({:configure, opts}, %{name: name}=state) do
    {:ok, :ok, configure(name, opts, state)}
  end

  # Handle the flush event
  def handle_event(:flush, state) do
    {:ok, state}
  end

  # Handle any log messages that are sent across
  def handle_event({level, _group_leader, {Logger, message, timestamp, metadata}}, %{level: min_level}=state) do
    if right_log_level?(min_level, level) do
      Runnable.LogFormatter.format(level, message, timestamp, metadata)
      |> IO.puts()
    end
    {:ok, state}
  end

  defp right_log_level?(nil, _level), do: true
  defp right_log_level?(min_level, level) do
    Logger.compare_levels(level, min_level) != :lt
  end

  defp configure(name, []) do
    base_level = Application.get_env(:logger, :level, :debug)
    Application.get_env(:logger, name, []) |> Enum.into(%{name: name, level: base_level})
  end

  defp configure(_name, [level: new_level], state) do
    Map.merge(state, %{level: new_level})
  end
  defp configure(_name, _opts, state), do: state
end