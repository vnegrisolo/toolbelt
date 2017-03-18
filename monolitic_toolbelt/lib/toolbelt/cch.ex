defmodule Toolbelt.Cch do
  @moduledoc "Runs checks against changed files"

  alias Toolbelt.FileSystem
  alias TbSystem.IO
  alias TbSystem.Command

  @typedoc "List of files"
  @type files :: list(String.t)

  @configs Application.fetch_env!(:tb_cch)

  @doc "runs a command for files after transforms and filter"
  @spec run(atom | Map.t, files) :: {:ok} | {:none}
  def run(config, files \\ TBGit.File.changed)
  def run(config, files) when is_atom(config), do: run(@configs[config], files)
  def run(config, files), do: do_run(files, config)

  defp do_run(files, config = %{transforms: [transform | list]}) do
    files
    |> FileSystem.transform(transform)
    |> do_run(%{config | transforms: list})
  end
  defp do_run(files, config = %{filter: filter}) when filter != nil do
    files
    |> FileSystem.filter(filter)
    |> do_run(Map.delete(config, :filter))
  end
  defp do_run([], %{command: command}) do
    IO.puts([:red, "No files to run Cch for #{command}"])
    {:none}
  end
  defp do_run(files, %{command: command}) do
    IO.puts([:green, "Running Cch for #{command}"])
    Command.run(command, files)
    {:ok}
  end
end
