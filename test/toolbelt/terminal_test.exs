defmodule Toolbelt.TerminalTest do
  use ExUnit.Case, async: true
  alias Toolbelt.Terminal
  doctest Terminal

  describe "Toolbelt.Terminal.puts/1" do
    test "prints out a colored text" do
      assert Terminal.puts([:cyan, "foo"]) == {:ok}
      assert Terminal.puts([:magenta, "bar"]) == {:ok}
    end
  end

  describe "Toolbelt.Terminal.colored_text/1" do
    test "colored text" do
      assert Terminal.colored_text("foo") == [:blue, "foo", :reset]
      assert Terminal.colored_text("bar") == [:white, "bar", :reset]
      assert Terminal.colored_text("foo") == [:blue, "foo", :reset]
    end
  end
end
