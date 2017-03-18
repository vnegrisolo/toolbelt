defmodule TBGit.Config do
  @moduledoc "git config"

  alias TbSystem.Command

  @typedoc "TBGit.Config values"
  @type t :: %__MODULE__{
    namespace: String.t,
    key:       String.t,
    global:    boolean
  }
  defstruct(
    namespace: nil,
    key:       nil,
    global:    false
  )

  @doc "get git config"
  @spec get(t) :: String.t
  def get(config = %TBGit.Config{namespace: namespace, key: key}) do
    run(config, ["--get", "#{namespace}.#{key}"])
  end

  @doc "set git config"
  @spec set(t, String.t) :: {:ok}
  def set(config = %TBGit.Config{namespace: namespace, key: key}, value) do
    run(config, ["#{namespace}.#{key}", value])
    {:ok}
  end

  @doc "reset git config"
  @spec reset(t) :: {:ok}
  def reset(config = %TBGit.Config{namespace: namespace}) do
    run(config, ["--remove-section", namespace])
    {:ok}
  end

  defp run(config, options) do
    [command(config), options]
    |> List.flatten
    |> Command.run
    |> List.first
  end

  defp command(config), do: ["git", "config", flags(config)]

  defp flags(%TBGit.Config{global: true}), do: ["--global"]
  defp flags(_config), do: []
end
