defmodule Toolbelt.Cch do
  @moduledoc "Runs checks against changed files"

  alias Toolbelt.Cch.Config
  alias Toolbelt.FileSystem
  alias Toolbelt.Git
  alias Toolbelt.Terminal

  @typedoc "List of files"
  @type files :: list(String.t)

  @configs %{
    haml_lint: %Config{
      command: "haml-lint",
      filter: ~r/\.haml$/
    },
    rspec: %Config{
      command: "rspec",
      transforms: [
        {~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/lib/\\1_spec.rb"}
      ],
      filter: ~r/_spec\.rb$/
    },
    rubocop: %Config{
      command: "rubocop",
      filter: ~r/\.rb$/
    },
  }

  @doc "runs a command for files after transforms and filter"
  @spec run(atom | Config.t, files) :: {:ok} | {:none}
  def run(config, files \\ Git.changed_files)
  def run(config, files) when is_atom(config), do: run(Map.fetch!(@configs, config), files)
  def run(config, files), do: do_run(files, config)

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
    Terminal.puts([:red, "No files to run Cch for #{command}"])
    {:none}
  end
  defp do_run(files, %Config{command: command}) do
    Terminal.puts([:green, "Running Cch for #{command}"])
    System.cmd(command, files)
    {:ok}
  end
end
