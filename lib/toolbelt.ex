defmodule Toolbelt do
  @moduledoc """
  Toolbelt module for project namespacing
  """

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
    Cch.run(Cch.config_rspec)
    Cch.run(Cch.config_rubocop)
    Cch.run(Cch.config_haml_lint)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [foo: :string]
    )
    options
  end
end
