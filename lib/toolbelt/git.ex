defmodule Toolbelt.Git do
  @moduledoc "Deals with git commands"

  alias Toolbelt.Git.Commit

  @git_commands [
    "git diff --name-only",
    "git diff --name-only --staged",
    "git diff --name-only ..master",
    "git ls-files --others --exclude-standard",
  ]

  @doc "list changed files"
  def changed_files do
    @git_commands
    |> Enum.map(&run_system_command/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  @doc "last 10 commits"
  def last_commits do
    {result, 0} = System.cmd("git", [
      "log",
      "-10",
      "--pretty=format:%h|%ae|%ce|%s"
    ])

    result
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.map(&build_commmit/1)
  end

  @doc "get git config"
  @spec get_config(String.t) :: String.t
  def get_config(key) do
    "git config --get #{key}"
    |> run_system_command
    |> List.first
  end

  @doc "set git config"
  @spec set_config(String.t, String.t) :: any
  def set_config(key, value) do
    run_system_command("git config #{key} #{value}")
  end

  @doc "reset git config"
  @spec reset_config(String.t) :: any
  def reset_config(key) do
    run_system_command("git config --remove-section #{key}")
  end

  @doc "get git global config"
  @spec get_global_config(String.t) :: String.t
  def get_global_config(key) do
    "git config --global --get #{key}"
    |> run_system_command
    |> List.first
  end

  @doc "set git global config"
  @spec set_global_config(String.t, String.t) :: any
  def set_global_config(key, value) do
    run_system_command("git config --global #{key} #{value}")
  end

  defp run_system_command(full_command) do
    [command | options] = String.split(full_command)
    {result, _status} = System.cmd(command, options)
    String.split(result)
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
