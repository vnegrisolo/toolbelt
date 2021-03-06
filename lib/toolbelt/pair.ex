defmodule Toolbelt.Pair do
  @moduledoc "Setup pair programming on git repo"

  alias Toolbelt.Git
  alias Toolbelt.Git.Commit
  alias Toolbelt.Terminal

  @pair_key "toolbelt.pair"
  @authors_key "#{@pair_key}.authors"

  def commit(args) do
    authors = @authors_key
              |> Git.get_config
              |> String.split(",")
              |> Enum.map(&Git.get_config("#{@pair_key}.#{&1}", global: true))
              |> Enum.map(&parse_author/1)

    last_author = Git.last_commit.author

    index = Enum.find_index(authors, fn(a) -> a["email"] == last_author end) || 0
    author = Enum.at(authors, index - 1)
    committer = Enum.at(authors, index)

    options = [
      {"GIT_AUTHOR_NAME",     author["name"]},
      {"GIT_AUTHOR_EMAIL",    author["email"]},
      {"GIT_COMMITTER_NAME",  committer["name"]},
      {"GIT_COMMITTER_EMAIL", committer["email"]}
    ]
    System.cmd(["git"|args], env: options)
  end

  defp parse_author(author) do
    Regex.named_captures(~r/^(?<name>.+) <(?<email>.+)>/, author)
  end

  @doc "configure pair authors"
  @spec configure(list(String.t)) :: {:ok}
  def configure([]), do: {:ok}
  def configure(authors) do
    do_configure(authors)
    authors
    |> Enum.join(",")
    |> Git.set_config(@authors_key)
  end

  def reset do
    Git.reset_config(@pair_key)
  end

  @doc "print pair status"
  def print_status do
    print_authors(Git.get_config(@authors_key))
    Git.last_commits |> Enum.each(&print_commit/1)
    {:ok}
  end

  defp do_configure([]), do: {:ok}
  defp do_configure([author|list]) do
    Git.get_config("#{@pair_key}.#{author}", global: true) || do_configure(author)
    do_configure(list)
  end
  defp do_configure(author) do
    Terminal.puts(["##### ", :cyan, author, :reset, " #####"])
    email = Terminal.gets(["type your ", :yellow, "email", :reset, ": "])
    name = Terminal.gets(["type your ", :yellow, "name", :reset, ": "])
    Git.set_config("#{name} <#{email}>", "#{@pair_key}.#{author}", global: true)
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
