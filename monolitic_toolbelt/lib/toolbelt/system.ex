defmodule Toolbelt.System do
  @moduledoc "System functions"

  alias TbSystem.IO

  @doc "runs a system command"
  @spec cmd(String.t | list(String.t), list(any)) :: String.t
  def cmd(command, options \\ [])
  def cmd(full_command = [command|options], cmd_options) do
    IO.puts([:yellow, "command: ", :reset, Enum.join(full_command, " ")])
    {result, _status} = System.cmd(command, List.flatten(options))
    String.trim(result)
  end
  def cmd(full_command, cmd_options) do
    full_command
    |> String.split
    |> cmd(cmd_options)
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
