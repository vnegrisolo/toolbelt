defmodule Toolbelt.Terminal do
  @moduledoc "Terminal outputs"

  @colors ~w[blue cyan green magenta red white yellow]a

  @doc "print out a colored text"
  @spec puts(list(String.t | atom)) :: {:ok}
  def puts(list) do
    [list | [:reset]]
    |> List.flatten
    |> IO.ANSI.format_fragment(true)
    |> IO.puts
    {:ok}
  end

  @doc "get a colored version of a text based on its sha value"
  @spec colored_text(String.t) :: list(String.t | atom)
  def colored_text(text) do
    count = Enum.count(@colors)
    index = :sha
            |> :crypto.hash(text)
            |> :binary.decode_unsigned
            |> rem(count)
    color = Enum.at(@colors, index)

    [color, text, :reset]
  end
end
