defmodule TbGit.File do
  @moduledoc "git file"

  alias TbSystem.Command

  @changed_commands [
    "git diff --name-only",
    "git diff --name-only --staged",
    "git diff --name-only ..master",
    "git ls-files --others --exclude-standard",
  ]

  @doc "list changed files"
  def changed do
    @changed_commands
    |> Enum.map(&Command.run/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end
end
