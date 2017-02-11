defmodule Toolbelt.Cch do
  @moduledoc """
  Toolbelt.Cch module runs checks against changed files
  """

  alias Toolbelt.Git
  alias Toolbelt.FileSystem

  defmodule Config do
    @moduledoc """
    Toolbelt.Cch.Config struct holds config values
    """
    defstruct command: "echo", transforms: [], filter: nil
  end

  @typedoc """
  List of files
  """
  @type files :: list(String.t)

  @typedoc """
  Transforms info
  """
  @type transforms :: list({Regex.t, String.t})

  @typedoc """
  Config values
  """
  @type config :: %Config{command: String.t, transforms: transforms, filter: String.t}

  @doc """
  Runs a command for files after transforms and filter
  """
  @spec run(files, config) :: any
  def run(files \\ Git.changed_files, config)
  def run(files, config = %Config{transforms: [transform | list]}) do
    files
    |> FileSystem.transform(transform)
    |> run(%{config | transforms: list})
  end
  def run(files, config = %Config{filter: filter}) when filter != nil do
    files
    |> FileSystem.filter(filter)
    |> run(Map.delete(config, :filter))
  end
  def run([], %Config{command: command}) do
    IO.puts("No files to run for #{command}")
    {:error}
  end
  def run(files, %Config{command: command}) do
    System.cmd(command, files)
    {:ok}
  end

  def config_rspec do
    %Config{
      command: "rspec",
      transforms: [
        {~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/lib/\\1_spec.rb"}
      ],
      filter: ~r/_spec\.rb$/
    }
  end

  def config_rubocop do
    %Config{
      command: "rubocop",
      filter: ~r/\.rb$/
    }
  end

  def config_haml_lint do
    %Config{
      command: "haml-lint",
      filter: ~r/\.haml$/
    }
  end
end
