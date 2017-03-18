defmodule Toolbelt.Git do
  @moduledoc "Deals with git commands"

  alias TbSystem.Command

  @changed_files_commands [
    "git diff --name-only",
    "git diff --name-only --staged",
    "git diff --name-only ..master",
    "git ls-files --others --exclude-standard",
  ]

  @doc "list changed files"
  def changed_files do
    @changed_files_commands
    |> Enum.map(&Command.run/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end
end
