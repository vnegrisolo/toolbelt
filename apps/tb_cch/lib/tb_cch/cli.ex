defmodule TbCch.CLI do
  @moduledoc """
  CLI for cch => Runs commands against changed files in git
  """

  @configs Application.fetch_env!(:tb_cch, :run)

  @doc "this is the main function for the script"
  @spec main(list(String.t)) :: any
  def main(args) do
    args |> parse_args |> run
  end

  defp parse_args(args) do
    OptionParser.parse(args, aliases: [h: :help])
  end

  defp run({[h:    true], _argv, _invalids}), do: print_help()
  defp run({[help: true], _argv, _invalids}), do: print_help()
  defp run({switches, _argv, _invalids}) do
    switches
    |> Keyword.keys
    |> Enum.map(&config/1)
    |> Enum.map(&do_run/1)
  end

  defp print_help do
    TbSystem.IO.puts(@moduledoc)
  end

  defp config(name) do
    Map.fetch!(@configs, name)
  end

  defp do_run(config) do
    TbSystem.IO.puts [:yellow, inspect config]
  end
end
