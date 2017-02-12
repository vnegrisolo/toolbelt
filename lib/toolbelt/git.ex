defmodule Toolbelt.Git do
  @moduledoc "Deals with git commands"

  @git_commands [
    "git diff --name-only",
    "git diff --name-only --staged",
    "git diff --name-only ..master",
    "git ls-files --others --exclude-standard",
  ]

  @doc "List changed files"
  def changed_files do
    @git_commands
    |> Enum.map(&run_system_command/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  defp run_system_command(full_command) do
    [command | options] = String.split(full_command)
    {result, 0} = System.cmd(command, options)
    String.split(result)
  end
end
