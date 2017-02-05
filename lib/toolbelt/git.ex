defmodule Toolbelt.Git do
  @doc """
  List changed files
  """
  def changed_files do
    git_commands
    |> Enum.map(&run/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  defp run([command | options]) do
    {result, 0} = System.cmd(command, options)
    result |> String.split
  end

  defp git_commands do
    [
      "git diff --name-only",
      "git ls-files --others --exclude-standard",
      "git diff --name-only --staged",
      "git diff --name-only ..master"
    ] |> Enum.map(&String.split/1)
  end
end
