defmodule Toolbelt.Pair do
  @moduledoc "Setup pair programming on git repo"

  alias TBGit.Author
  alias TBGit.Commit
  alias TBGit.Config
  alias TbSystem.IO
  alias TbSystem.Command

  @config_authors %Config{
    namespace: "pair",
    key:       "authors"
  }

  def commit(args) do
    authors = @config_authors
              |> Config.get
              |> String.split(",")
              |> Enum.map(&config_author/1)
              |> Enum.map(&Config.get)
              |> Enum.map(&parse_author/1)

    last_author = Commit.last_commit.author.email

    index = Enum.find_index(authors, fn(a) -> a["email"] == last_author end) || 0
    author = Enum.at(authors, index - 1)
    committer = Enum.at(authors, index)

    options = [
      {"GIT_AUTHOR_NAME",     author["name"]},
      {"GIT_AUTHOR_EMAIL",    author["email"]},
      {"GIT_COMMITTER_NAME",  committer["name"]},
      {"GIT_COMMITTER_EMAIL", committer["email"]}
    ]
    Command.run(["git" | args], env: options)
  end

  defp parse_author(author) do
    Regex.named_captures(~r/^(?<name>.+) <(?<email>.+)>/, author)
  end

  @doc "configure pair authors"
  @spec configure(list(String.t)) :: {:ok}
  def configure([]), do: {:ok}
  def configure(authors) do
    do_configure(authors)
    @config_authors
    |> Config.set(Enum.join(authors, ","))
  end

  def reset do
    Config.reset(@config_authors)
  end

  @doc "print pair status"
  def print_status do
    @config_authors |> Config.get |> print_authors
    Commit.last_commits |> Enum.each(&print_commit/1)
    {:ok}
  end

  defp do_configure([]), do: {:ok}
  defp do_configure([author|list]) do
    config_author(author) |> Config.get || do_configure(author)
    do_configure(list)
  end
  defp do_configure(author) do
    IO.puts(["##### ", :cyan, author, :reset, " #####"])
    email = IO.gets(["type your ", :yellow, "email", :reset, ": "])
    name  = IO.gets(["type your ", :yellow, "name",  :reset, ": "])

    config_author(author)
    |> Config.set("#{name} <#{email}>")
  end

  defp print_commit(%Commit{sha: sha, author: %Author{email: author}, committer: %Author{email: committer}, message: message}) do
    colored_author    = IO.add_color(author)
    colored_committer = IO.add_color(committer)
    [sha, " | ", colored_author, " | ", colored_committer, " => ", message]
    |> IO.puts
  end

  defp print_authors(nil), do: {:none}
  defp print_authors(authors) do
    authors
    |> String.split(",")
    |> Enum.map(&IO.add_color/1)
    |> Enum.map(&["Author: ", &1, "\n"])
    |> IO.puts
  end

  defp config_author(author) do
    %Config{
      namespace: "pair",
      key:       author,
      global:    true
    }
  end
end
