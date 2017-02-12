defmodule Toolbelt do
  @moduledoc "Main Toolbelt module for executable"

  alias Toolbelt.Cch

  @spec main(list(String.t)) :: any
  def main(args) do
    IO.puts "Hello world"
    IO.puts args
    args |> parse_args |> process
  end

  defp process([]) do
    IO.puts "No arguments given"
  end
  defp process(options) do
    IO.puts options
    IO.puts "Hello #{options[:name]}"
    {:ok} = Cch.run_rubocop()
    {:ok} = Cch.run_haml_lint()
    {:ok} = Cch.run_rspec()
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [foo: :string]
    )
    options
  end
end
