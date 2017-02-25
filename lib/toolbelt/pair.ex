defmodule Toolbelt.Pair do
  @moduledoc "Setup pair programming on git repo"

  alias Toolbelt.Git
  alias Toolbelt.Git.Commit
  alias Toolbelt.Terminal

  @authors_key "toolbelt.pair.authors"

  @doc "print pair status"
  def print_status do
    print_authors(Git.get_config(@authors_key))
    Git.last_commits |> Enum.each(&print_commit/1)
    {:ok}
  end

  defp print_commit(%Commit{sha: sha, author: author, committer: committer, message: message}) do
    colored_author    = Terminal.colored_text(author)
    colored_committer = Terminal.colored_text(committer)
    [sha, " | ", colored_author, " | ", colored_committer, " => ", message]
    |> Terminal.puts
  end

  defp print_authors(nil), do: {:none}
  defp print_authors(authors) do
    authors
    |> String.split(",")
    |> Enum.map(&Terminal.colored_text/1)
    |> Enum.map(&["Author: ", &1, "\n"])
    |> Terminal.puts
  end
end
