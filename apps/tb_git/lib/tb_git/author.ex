defmodule TbGit.Author do
  @moduledoc "git author"

  @typedoc "TbGit.Author values"
  @type t :: %__MODULE__{
    name: String.t,
    email: String.t
  }
  defstruct(
    name: nil,
    email: nil
  )
end
