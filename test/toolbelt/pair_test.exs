defmodule Toolbelt.PairTest do
  use ExUnit.Case, async: true
  alias Toolbelt.Pair
  doctest Pair

  describe "Toolbelt.Pair.configure/1" do
    @tag :skip
    test "configures pair" do
      assert Pair.configure(["vnegrisolo", "another-dev"]) == {:ok}
    end
  end

  describe "Toolbelt.Pair.reset/0" do
    test "reset pair configuration" do
      assert Pair.reset == {:ok}
    end
  end

  describe "Toolbelt.Pair.print_status/0" do
    test "prints pair status" do
      assert Pair.print_status == {:ok}
    end
  end
end
