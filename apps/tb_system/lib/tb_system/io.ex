defmodule TbSystem.IO do
  @moduledoc "IO for terminal"

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

  defp format_color(text) do
    [text, :reset]
    |> List.flatten
    |> IO.ANSI.format_fragment(true)
  end
end
