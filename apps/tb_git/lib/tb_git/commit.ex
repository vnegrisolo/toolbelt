defmodule TBGit.Commit do
  @moduledoc "git commit"

  alias TbGit.Author

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
end
