defmodule TbSystem.IO.Mock do
  @moduledoc "IO mock"

  @spec puts(String.t) :: atom
  def puts(_message), do: :ok

  @spec gets(String.t) :: String.t
  def gets(_message), do: "user input"
end
