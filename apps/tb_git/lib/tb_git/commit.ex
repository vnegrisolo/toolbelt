defmodule TBGit.Commit do
  @moduledoc "git commit"

  alias TbGit.Author
  alias TbSystem.Command

  @typedoc "TBGit.Commit values"
  @type t :: %__MODULE__{
    sha: String.t,
    author: Author.t,
    committer: Author.t,
    message: String.t,
  }
  defstruct(
    sha: nil,
    author: nil,
    committer: nil,
    message: nil,
  )

  @doc "last n commits"
  @spec last_commits(integer) :: list(String.t)
  def last_commits(count \\ 10) do
    "git log -#{count} --pretty=format:%h|%ae|%ce|%s"
    |> Command.run
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.map(&build_commmit/1)
  end

  @doc "last commit"
  def last_commit, do: List.first(last_commits(1))

  defp build_commmit([sha, author_email, committer_email, message]) do
    %__MODULE__{
      sha: sha,
      author: %TBGit.Author{email: author_email},
      committer: %TBGit.Author{email: committer_email},
      message: message,
    }
  end
end
