defmodule Toolbelt.Cch do
  @moduledoc """
  Toolbelt.Cch  module runs checks against changed files
  """

  alias Toolbelt.Git
  alias Toolbelt.FileSystem
  import FileSystem, only: [filter: 2, transform: 3]

  @typedoc """
  List of files
  """
  @type files :: list(String.t)

  @doc """
  Runs a command for changed files
  """
  @spec run(String.t, files) :: tuple
  def run(command, files \\ Git.changed_files)

  def run(:rspec, files) do
    files
    |> transform(~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb")
    |> transform(~r/^lib\/(.+)\.rb$/, "spec/\\1_spec.rb")
    |> transform(~r/^lib\/(.+)\.rb$/, "spec/lib/\\1_spec.rb")
    |> filter(~r/_spec\.rb$/)
    |> execute("rspec")
  end

  def run(:rubocop, files) do
    files
    |> filter(~r/\.rb$/)
    |> execute("rubocop")
  end

  def run(:haml_lint, files) do
    files
    |> filter(~r/\.haml$/)
    |> execute("haml-lint")
  end

  defp execute([], command), do: IO.puts("No files to run for #{command}")
  defp execute(files = [_|_], command), do: System.cmd(command, files)
end
