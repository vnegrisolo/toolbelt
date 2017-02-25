defmodule Toolbelt.System do
  @moduledoc "System functions"

  alias Toolbelt.Terminal

  @doc "runs a system command"
  @spec cmd(String.t) :: String.t
  def cmd(full_command) do
    Terminal.puts([:yellow, "command: ", :reset, full_command])
    [command | options] = String.split(full_command)
    {result, _status} = System.cmd(command, options)
    String.trim(result)
  end

  @doc "splits a system command result"
  @spec split_result(String.t) :: list(String.t)
  def split_result(result) do
    result
    |> String.split
    |> flat_compact
  end

  @doc "splits a system command result by a separator"
  @spec split_result(String.t, String.t) :: list(String.t)
  def split_result(result, separator) do
    result
    |> String.split(separator)
    |> flat_compact
  end

  defp flat_compact(results) do
    results
    |> List.flatten
    |> Enum.reject(&is_nil/1)
  end
end
