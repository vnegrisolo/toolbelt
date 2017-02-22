defmodule Toolbelt.Pair do
  @moduledoc "Setup pair programming on git repo"

  alias Toolbelt.Git
  alias Toolbelt.Git.Commit

  @authors_key "toolbelt.pair.authors"

  @doc "print pair status"
  def print_status do
    print_authors(Git.get_config(@authors_key))
    Git.last_commits |> Enum.each(&print_commit/1)
    {:ok}
  end

  @colors ~w[blue cyan green magenta red white yellow]a

  defp print_commit(%Commit{sha: sha, author: author, committer: committer, message: message}) do
    [sha, " | ", colored_author(author), :reset, " | ", colored_author(committer), :reset, " => ", message]
    |> List.flatten
    |> IO.ANSI.format_fragment(true)
    |> IO.puts
  end

  defp print_authors(nil), do: {:none}
  defp print_authors(authors) do
    authors
    |> String.split(",")
    |> Enum.map(& colored_author/1)
    |> Enum.map(& ["Author: ", &1, :reset, "\n"])
    |> List.flatten
    |> IO.ANSI.format_fragment(true)
    |> IO.puts
  end

  defp colored_author(author) do
    count = Enum.count(@colors)
    author_hash = :crypto.hash(:sha, author)
    [Enum.at(@colors, rem(:binary.decode_unsigned(author_hash), count)), author]
  end
end
