defmodule Toolbelt.Git.Commit do
  @moduledoc "Struct for holding `Git` commit values"

  @typedoc "Toolbelt.Git.Commit values"
  @type t :: %__MODULE__{
    sha: String.t,
    author: String.t,
    committer: String.t,
    message: String.t,
  }
  defstruct(
    sha: nil,
    author: nil,
    committer: nil,
    message: nil,
  )
end
