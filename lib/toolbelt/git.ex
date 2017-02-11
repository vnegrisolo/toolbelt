defmodule Toolbelt.Git do
  @moduledoc """
  Toolbelt.Git module deals with git commands
  """

  @doc """
  List changed files
  """
  def changed_files do
    git_commands
    |> Enum.map(&run_system_command/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  defp run_system_command(full_command) do
    [command | options] = String.split(full_command)
    {result, 0} = System.cmd(command, options)
    result |> String.split
  end

  defp git_commands do
    [
      "git diff --name-only",
      "git ls-files --others --exclude-standard",
      "git diff --name-only --staged",
      "git diff --name-only ..master"
    ]
  end
end
