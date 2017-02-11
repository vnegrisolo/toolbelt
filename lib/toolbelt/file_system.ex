defmodule Toolbelt.FileSystem do
  @moduledoc """
  Toolbelt.FileSystem module deals with files in the file system
  """

  @typedoc """
  File path
  """
  @type file :: String.t

  @typedoc """
  List of files
  """
  @type files :: list(file)

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
  @spec transform(files, Regex.t, String.t) :: files
  def transform([], _, _), do: []
  def transform([file | list], regex, replacement) do
    [file | [Regex.replace(regex, file, replacement) | transform(list, regex, replacement)]]
    |> Enum.sort
    |> Enum.uniq
  end
end
