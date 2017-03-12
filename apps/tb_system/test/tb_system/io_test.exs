defmodule TbSystem.IOTest do
  use ExUnit.Case, async: true
  alias TbSystem.IO
  doctest IO
  import ExUnit.CaptureIO

  describe "IO.gets/1" do
    test "reads input" do
      assert capture_io(
        " bar ",
        fn ->
          assert IO.gets([:cyan, "foo?"]) == "bar"
        end
      ) == "\e[36mfoo?\e[0m"
    end
  end

  describe "IO.puts/1" do
    test "prints colored text" do
      assert capture_io(
        fn ->
          assert IO.puts([:red,  "foo"]) == :ok
        end
      ) == "\e[31mfoo\e[0m\n"
    end
  end
end
