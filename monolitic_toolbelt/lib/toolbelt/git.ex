defmodule Toolbelt.Git do
  @moduledoc "Deals with git commands"

  alias TbSystem.Command

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
    |> Enum.map(&Command.run/1)
    |> List.flatten
    |> Enum.sort
    |> Enum.uniq
  end

  @doc "get git config"
  @spec get_config(String.t, config_flags) :: String.t
  def get_config(key, flags \\ [])
  def get_config(key, global: true), do: get_config(key, ["--global"])
  def get_config(key, flags) do
    "git config #{flags} --get #{key}"
    |> Command.run
    |> String.trim
  end

  @doc "set git config"
  @spec set_config(String.t, String.t, config_flags) :: {:ok}
  def set_config(value, key, flags \\ [])
  def set_config(value, key, global: true), do: set_config(value, key, ["--global"])
  def set_config(value, key, flags) do
    Command.run(["git", "config", flags, key, value])
    {:ok}
  end

  @doc "reset git config"
  @spec reset_config(String.t, config_flags) :: {:ok}
  def reset_config(key, flags \\ [])
  def reset_config(key, global: true), do: reset_config(key, ["--global"])
  def reset_config(key, flags) do
    Command.run("git config #{flags} --remove-section #{key}")
    {:ok}
  end
end
