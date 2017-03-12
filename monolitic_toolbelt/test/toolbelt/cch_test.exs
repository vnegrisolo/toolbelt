defmodule Toolbelt.CchTest do
  use ExUnit.Case, async: true
  alias Toolbelt.Cch
  alias Toolbelt.Cch.Config
  doctest Cch

  describe "Toolbelt.Cch.run/2" do
    @config %Config{command: "echo"}
    @filter_md ~r/\.md$/
    @transform_csv_to_md {~r/(.+)\.csv$/, "\\1.md"}

    test "does not run with no files" do
      assert Cch.run(@config, []) == {:none}
    end
    test "does not run after filter files out" do
      config = %{@config | filter: @filter_md}
      assert Cch.run(config, ~w[README.csv]) == {:none}
    end

    test "runs command with files" do
      assert Cch.run(@config, ~w[README.md]) == {:ok}
    end
    test "runs command with filtered files" do
      config = %{@config | filter: @filter_md}
      assert Cch.run(config, ~w[README.md]) == {:ok}
    end
    test "runs command with transformed and filtered files" do
      config = %{@config | transforms: [@transform_csv_to_md], filter: @filter_md}
      assert Cch.run(config, ~w[README.csv]) == {:ok}
    end
  end
end
