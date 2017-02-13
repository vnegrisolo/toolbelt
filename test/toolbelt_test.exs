defmodule ToolbeltTest do
  use ExUnit.Case, async: true
  doctest Toolbelt

  describe "Toolbelt.main/1" do
    test "does not run when arguments is missing" do
      assert Toolbelt.main([]) == {:none}
    end

    test "does not run cch when there are no switches" do
      assert Toolbelt.main(["cch"]) == []
    end
  end
end
