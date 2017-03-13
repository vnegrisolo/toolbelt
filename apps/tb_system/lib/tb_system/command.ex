defmodule TbSystem.Command do
  @moduledoc "System commands in terminal"

  alias TbSystem.IO

  @doc "runs a system command"
  @spec run(String.t | list(String.t), list(any)) :: list(String.t)
  def run(command, options \\ [])
  def run(full_command = [command | args], [{:separator, separator} | options]) do
    IO.puts([:yellow, "command: ", :reset, Enum.join(full_command, " ")])

    command
    |> System.cmd(List.flatten(args), options)
    |> split_result(separator)
  end
  def run(command, options) when is_list(command) do
    run(command, [{:separator, "\n"} | options])
  end
  def run(command, options) do
    command
    |> String.split(" ")
    |> run(options)
  end

  defp split_result({result, _status}, separator) do
    result
    |> String.trim
    |> String.split(separator)
    |> List.flatten
    |> Enum.reject(&is_blank/1)
  end

  defp is_blank(value) do
    is_nil(value) || value == ""
  end
end
