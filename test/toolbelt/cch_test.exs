defmodule Toolbelt.CchTest do
  use ExUnit.Case, async: true
  alias Toolbelt.Cch
  doctest Cch

  test "runs for rspec" do
    assert Cch.run(:rspec, []) == :ok
  end

  test "runs for rubocop" do
    assert Cch.run(:rubocop, []) == :ok
  end

  test "runs for haml_lint" do
    assert Cch.run(:haml_lint, []) == :ok
  end
end
