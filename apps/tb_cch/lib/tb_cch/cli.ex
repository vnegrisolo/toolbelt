defmodule TbCch.CLI do
  @moduledoc """
  CLI for cch => Runs commands against changed files in git
  """

  alias TbSystem.IO

  # @configs Application.fetch_env!(:tb_cch)

  @doc "this is the main function for the script"
  @spec main(list(String.t)) :: any
  def main(args) do
    IO.puts [:cyan, inspect args]
    args |> parse_args |> run
  end

  defp parse_args(args) do
    OptionParser.parse(args, aliases: [h: :help])
  end

  defp run({[h:    true], _argv, _invalids}), do: print_help()
  defp run({[help: true], _argv, _invalids}), do: print_help()

  defp print_help do
    IO.puts(@moduledoc)
  end
end
