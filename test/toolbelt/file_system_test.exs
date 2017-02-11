defmodule Toolbelt.FileSystemTest do
  use ExUnit.Case, async: true
  alias Toolbelt.FileSystem
  doctest FileSystem

  describe "Toolbelt.FileSystem.filter/2" do
    test "filters existing files that matches a pattern" do
      files = ~w[mix.exs non_existing.exs README.md]
      assert FileSystem.filter(files, ~r/\.exs$/) == ~w[mix.exs]
    end
  end

  describe "Toolbelt.FileSystem.transform/3" do
    test "transforms files that matches a pattern" do
      files = ~w[app/models/user.rb non_matching.exs]
      result = FileSystem.transform(files, ~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb")
      assert result == ~w[app/models/user.rb non_matching.exs spec/models/user_spec.rb]
    end
  end
end
