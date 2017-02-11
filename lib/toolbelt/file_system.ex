defmodule Toolbelt.FileSystem do
  @moduledoc """
  Toolbelt.FileSystem module deals with files in the file system
  """

  @typedoc """
  List of files
  """
  @type files :: list(String.t)

  @typedoc """
  Transform info
  """
  @type transform :: {Regex.t, String.t}

  @doc """
  Filters a list of existing files by a regex
  """
  @spec filter(files, Regex.t) :: files
  def filter(files, regex) do
    files
    |> Enum.filter(&File.exists?/1)
    |> Enum.filter(&Regex.match?(regex, &1))
  end

  @doc """
  Transforms a list of files by a regex
  """
  @spec transform(files, transform) :: files
  def transform([], _), do: []
  def transform([file | list], transform_info = {regex, replacement}) do
    [file | [Regex.replace(regex, file, replacement) | transform(list, transform_info)]]
    |> Enum.sort
    |> Enum.uniq
  end
end
