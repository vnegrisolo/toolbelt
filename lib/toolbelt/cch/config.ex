defmodule Toolbelt.Cch.Config do
  @moduledoc "Struct for holding `Cch` config values"

  @typedoc "Toolbelt.Cch.Config values"
  @type t :: %__MODULE__{
    command: String.t,
    filter: String.t,
    transforms: list({Regex.t, String.t}),
  }
  defstruct(
    command: "echo",
    filter: nil,
    transforms: [],
  )
end
