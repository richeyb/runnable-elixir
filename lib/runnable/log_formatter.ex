defmodule Runnable.LogFormatter do
  @protected [:request_id]

  def format(level, message, timestamp, metadata) do
    "##### #{fmt_timestamp(timestamp)} #{fmt_metadata(metadata)} [#{level}] #{message}\n"
  rescue
    _ -> "could not format message: #{inspect({level, message, timestamp, metadata})}\n"
  end

  defp fmt_metadata(md) do
    md
    |> Keyword.keys()
    |> Enum.map(&(output_metadata(md, &1)))
    |> Enum.join(" ")
  end

  def output_metadata(metadata, key) do
    if Enum.member?(@protected, key) do
      "#{key}=(REDACTED)"
    else
      "#{key}=#{inspect(metadata[key])}"
    end
  end

  defp fmt_timestamp({date, {hh, mm, ss, ms}}) do
    with {:ok, timestamp} <- NaiveDateTime.from_erl({date, {hh, mm, ss}}, {ms * 1000, 3}),
      result <- NaiveDateTime.to_iso8601(timestamp)
    do
      "#{result}Z"
    end
  end
end