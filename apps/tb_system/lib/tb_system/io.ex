defmodule TbSystem.IO do
  @moduledoc "IO for terminal"

  @colors ~w[blue cyan green magenta red white yellow]a

  @doc "reads input with colored message"
  @spec gets(list(String.t | atom)) :: String.t
  def gets(text) do
    text
    |> format_color
    |> IO.gets
    |> String.trim
  end

  @doc "print colored message"
  @spec puts(list(String.t | atom)) :: :ok
  def puts(text) do
    text
    |> format_color
    |> IO.puts
  end

  @doc "add color to text"
  @spec add_color(String.t) :: list(String.t | atom)
  def add_color(text) do
    [color_for(text), text, :reset]
  end

  defp format_color(text) do
    [text, :reset]
    |> List.flatten
    |> IO.ANSI.format_fragment(true)
  end

  defp color_for(text) do
    count = Enum.count(@colors)
    index = :sha
            |> :crypto.hash(text)
            |> :binary.decode_unsigned
            |> rem(count)

    Enum.at(@colors, index)
  end
end
