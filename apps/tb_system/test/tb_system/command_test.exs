defmodule TbSystem.CommandTest do
  use ExUnit.Case, async: true
  alias TbSystem.Command
  doctest Command

  describe "run/2" do
    test "runs a system command" do
      assert Command.run("echo foo bar") == ["foo bar"]
      assert Command.run("echo foo\nbar") == ~w[foo bar]
      assert Command.run("echo foo|bar", separator: "|") == ~w[foo bar]
      assert Command.run("echo |foo||bar|", separator: "|") == ~w[foo bar]

      assert Command.run(~w[echo foo bar]) == ["foo bar"]
      assert Command.run(["echo", "foo\nbar"]) == ~w[foo bar]
      assert Command.run(~w[echo foo|bar], separator: "|") == ~w[foo bar]
    end
  end
end
