defmodule ToolbeltTest do
  use ExUnit.Case, async: true
  doctest Toolbelt

  describe "Toolbelt.main/1" do
    test "prints help message" do
      assert Toolbelt.main("help")   == {:help}
      assert Toolbelt.main("-h")     == {:help}
      assert Toolbelt.main("--help") == {:help}
    end

    test "does not run cch when there are no switches" do
      assert Toolbelt.main("cch") == []
    end

    test "raises an KeyError when switch is invalid" do
      assert_raise KeyError, fn ->
        Toolbelt.main("cch --fake-switch")
      end
    end

    test "calls Pair print_status" do
      assert Toolbelt.main("pair --status") == {:ok}
    end
  end
end
