defmodule TBGit.Author do
  @moduledoc "git author"

  @typedoc "TBGit.Author values"
  @type t :: %__MODULE__{
    name: String.t,
    email: String.t
  }
  defstruct(
    name: nil,
    email: nil
  )
end
