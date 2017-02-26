defmodule Toolbelt do
  @moduledoc """
  Toolbelt module for being package as an executable script.

  ## usage:

  ```shell
  toolbelt <process> [<options>]
  ```

  ## cch

  * `--rspec`
  * `--rubocop`
  * `--haml-lint`

  ### example:

  ```shell
  toolbelt cch --rspec --rubocop
  ```

  ## pair

  * `user1 user2 user3`
  * `--status`
  * `--reset`

  ### example:

  ```shell
  toolbelt pair --reset
  toolbelt pair vnegrisolo other-dev
  toolbelt pair --status
  ```
  """

  alias Toolbelt.Cch
  alias Toolbelt.Pair

  @doc "this is the main function for the script"
  @spec main(list(String.t)) :: any
  def main(args) when is_binary(args), do: args |> String.split |> main
  def main(args), do: args |> parse_args |> process

  defp parse_args(args), do: OptionParser.parse(args, aliases: [h: :help])

  defp process({[h: true], _argv, _invalids}),    do: print_help
  defp process({[help: true], _argv, _invalids}), do: print_help
  defp process({_switches, ["help"], _invalids}), do: print_help
  defp process({switches, ["cch"], _invalids}) do
    switches
    |> Keyword.keys
    |> Enum.map(&Cch.run/1)
  end
  defp process({[], ["pair"|authors], _invalids}) do
    Pair.reset
    Pair.configure(authors)
    {:ok}
  end
  defp process({[status: true], ["pair"], _invalids}) do
    Pair.print_status
    {:ok}
  end
  defp process({[reset: true], ["pair"], _invalids}) do
    Pair.reset
    {:ok}
  end

  defp print_help do
    IO.puts @moduledoc
    {:help}
  end
end
