defmodule TbSystem.IO do
  @moduledoc "IO for terminal"

  @io Application.fetch_env!(:tb_system, :io)
  @colors ~w[blue cyan green magenta red white yellow]a

  @typedoc "IO implementation"
  @type io :: IO | TbSystem.Mock.IO

  @doc "reads input with colored message"
  @spec gets(list(String.t | atom), io) :: String.t
  def gets(text, io \\ @io) do
    text
    |> format_color
    |> io.gets
    |> String.trim
  end

  @doc "print colored message"
  @spec puts(String.t | list(String.t | atom), io) :: :ok
  def puts(text, io \\ @io)
  def puts(text, io) when is_binary(text) do
    text |> String.split |> puts(io)
  end
  def puts(text, io) do
    text
    |> format_color
    |> io.puts
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
