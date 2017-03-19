defmodule TbSystem.IOTest do
  use ExUnit.Case, async: true
  doctest TbSystem.IO
  import ExUnit.CaptureIO

  setup do: {:ok, io: IO}

  describe "IO.gets/1" do
    test "reads input", %{io: io} do
      assert capture_io(
        " bar ",
        fn ->
          assert TbSystem.IO.gets([:cyan, "foo?"], io) == "bar"
        end
      ) == "\e[36mfoo?\e[0m"
    end
  end

  describe "IO.puts/1" do
    test "prints regular text", %{io: io} do
      assert capture_io(
        fn ->
          assert TbSystem.IO.puts("foo", io) == :ok
        end
      ) == "foo\e[0m\n"
    end

    test "prints colored text", %{io: io} do
      assert capture_io(
        fn ->
          assert TbSystem.IO.puts([:red,  "foo"], io) == :ok
        end
      ) == "\e[31mfoo\e[0m\n"
    end
  end

  describe "add_color/1" do
    test "add same color to text" do
      assert TbSystem.IO.add_color("foo") == [:blue,  "foo", :reset]
      assert TbSystem.IO.add_color("bar") == [:white, "bar", :reset]
    end
  end
end
