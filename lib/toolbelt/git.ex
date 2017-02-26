defmodule Toolbelt.Git do
  @moduledoc "Deals with git commands"

  alias Toolbelt.Git.Commit
  alias Toolbelt.System

  @typedoc "git config flags"
  @type config_flags :: Keyword.t | list(String.t)

  @changed_files_commands [
    "git diff --name-only",
    "git diff --name-only --staged",
    "git diff --name-only ..master",
    "git ls-files --others --exclude-standard",
  ]

  @doc "list changed files"
  def changed_files do
    @changed_files_commands
    |> Enum.map(&System.cmd/1)
    |> Enum.map(&System.split_result/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  @doc "last n commits"
  @spec last_commits(integer) :: String.t
  def last_commits(count \\ 10) do
    "git log -#{count} --pretty=format:%h|%ae|%ce|%s"
    |> System.cmd
    |> System.split_result("\n")
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.map(&build_commmit/1)
  end

  @doc "last commit"
  def last_commit, do: List.first(last_commits(1))

  @doc "get git config"
  @spec get_config(String.t, config_flags) :: String.t
  def get_config(key, flags \\ [])
  def get_config(key, global: true), do: get_config(key, ["--global"])
  def get_config(key, flags) do
    "git config #{flags} --get #{key}"
    |> System.cmd
    |> System.split_result
    |> List.first
  end

  @doc "set git config"
  @spec set_config(String.t, String.t, config_flags) :: {:ok}
  def set_config(key, value, flags \\ [])
  def set_config(key, value, global: true), do: set_config(key, value, ["--global"])
  def set_config(key, value, flags) do
    System.cmd("git config #{flags} #{key} #{value}")
    {:ok}
  end

  @doc "reset git config"
  @spec reset_config(String.t, config_flags) :: {:ok}
  def reset_config(key, flags \\ [])
  def reset_config(key, global: true), do: reset_config(key, ["--global"])
  def reset_config(key, flags) do
    System.cmd("git config #{flags} --remove-section #{key}")
    {:ok}
  end

  defp build_commmit([sha, author, committer, message]) do
    %Commit{
      sha: sha,
      author: author,
      committer: committer,
      message: message,
    }
  end
end
