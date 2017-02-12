defmodule Toolbelt.FileSystem do
  @moduledoc "Deals with files in the file system"

  @typedoc "List of files"
  @type files :: list(String.t)

  @typedoc "Transform info"
  @type transform :: {Regex.t, String.t}

  @doc "Filters a list of existing files by a regex"
  @spec filter(files, Regex.t) :: files
  def filter(files, regex) do
    files
    |> Enum.filter(&File.exists?/1)
    |> Enum.filter(&Regex.match?(regex, &1))
  end

  @doc "Transforms a list of files by a regex"
  @spec transform(files, transform) :: files
  def transform(files, transform) do
    files
    |> do_transform(transform)
    |> Enum.sort
    |> Enum.uniq
  end

  defp do_transform([], _), do: []
  defp do_transform([file | list], transform = {regex, replacement}) do
    transformed = Regex.replace(regex, file, replacement)
    [file | [transformed | do_transform(list, transform)]]
  end
end
