defmodule Toolbelt do
  @moduledoc "Main Toolbelt module for executable"

  alias Toolbelt.Cch

  @doc """
  this is the main function for the script

  Here is a **list of acceptable arguments**:

  ## **`cch`**
    - `--rspec`
    - `--rubocop`
    - `--haml-lint`

  ### Example:

  ```shell
  toolbelt cch --rspec
  ```
  """
  @spec main(list(String.t)) :: any
  def main(args), do: args |> parse_args |> process

  defp process({[], [], []}) do
    IO.puts "No arguments given"
    {:none}
  end
  defp process({switches, ["cch"], _invalids}) do
    Enum.filter_map(Cch.config_keys, &(switches[&1]), &Cch.run(&1))
  end

  defp parse_args(args), do: OptionParser.parse(args)
end
