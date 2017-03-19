defmodule TbCch.CLITest do
  use ExUnit.Case, async: false
  alias TbCch.CLI
  doctest CLI

  describe "main/1" do
    test "prints help message" do
      assert CLI.main(["-h"])     == :ok
      assert CLI.main(["--help"]) == :ok
    end
  end
end
