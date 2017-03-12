defmodule Toolbelt.SystemTest do
  use ExUnit.Case, async: false
  alias Toolbelt.System
  doctest System

  describe "cmd/1" do
    test "runs a system command" do
      assert System.cmd("echo foo bar") == "foo bar"
      assert System.cmd("echo foo|bar") == "foo|bar"
    end
  end

  describe "split_result/1" do
    test "splits system command result" do
      result = System.cmd("echo foo bar")
      assert System.split_result(result) == ~w[foo bar]
    end
  end

  describe "split_result/2" do
    test "splits system command result with a separator" do
      result = System.cmd("echo foo|bar")
      assert System.split_result(result, "|") == ~w[foo bar]
    end
  end
end
