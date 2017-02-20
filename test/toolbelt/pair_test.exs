defmodule Toolbelt.PairTest do
  use ExUnit.Case, async: true
  alias Toolbelt.Pair
  doctest Pair

  describe "Toolbelt.Pair.print_status/0" do
    test "prints pair status" do
      assert Pair.print_status == {:ok}
    end
  end
end
