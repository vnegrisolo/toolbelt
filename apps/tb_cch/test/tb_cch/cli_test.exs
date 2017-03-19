defmodule TbCch.CLITest do
  use ExUnit.Case, async: false
  alias TbCch.CLI
  doctest CLI

  describe "main/1" do
    test "prints help message" do
      assert CLI.main(["-h"])     == :ok
      assert CLI.main(["--help"]) == :ok
    end

    test "raises an KeyError when switch is invalid" do
      assert_raise KeyError, fn ->
        CLI.main(["--debug"])
      end
    end
  end
end
