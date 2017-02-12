defmodule Toolbelt.Cch do
  @moduledoc "Runs checks against changed files"

  alias Toolbelt.Cch.Config
  alias Toolbelt.FileSystem
  alias Toolbelt.Git

  @typedoc "List of files"
  @type files :: list(String.t)

  @haml_lint_config %Config{
    command: "haml-lint",
    filter: ~r/\.haml$/
  }

  @rspec_config %Config{
    command: "rspec",
    transforms: [
      {~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb"},
      {~r/^lib\/(.+)\.rb$/, "spec/\\1_spec.rb"},
      {~r/^lib\/(.+)\.rb$/, "spec/lib/\\1_spec.rb"}
    ],
    filter: ~r/_spec\.rb$/
  }

  @rubocop_config %Config{
    command: "rubocop",
    filter: ~r/\.rb$/
  }

  def run_haml_lint, do: run(@haml_lint_config)
  def run_rspec, do: run(@rspec_config)
  def run_rubocop, do: run(@rubocop_config)

  @doc "Runs a command for files after transforms and filter"
  @spec run(files, Config.t) :: {:ok} | {:none}
  def run(files \\ Git.changed_files, config) do
    do_run(files, config)
  end

  defp do_run(files, config = %Config{transforms: [transform | list]}) do
    files
    |> FileSystem.transform(transform)
    |> do_run(%{config | transforms: list})
  end
  defp do_run(files, config = %Config{filter: filter}) when filter != nil do
    files
    |> FileSystem.filter(filter)
    |> do_run(Map.delete(config, :filter))
  end
  defp do_run([], %Config{command: command}) do
    IO.puts("No files to run for #{command}")
    {:none}
  end
  defp do_run(files, %Config{command: command}) do
    System.cmd(command, files)
    {:ok}
  end
end
