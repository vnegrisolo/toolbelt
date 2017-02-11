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
      assert Cch.run([], @config) == {:error}
    end
    test "does not run after filter files out" do
      assert Cch.run(~w[README.csv], %{@config | filter: @filter_md}) == {:error}
    end

    test "runs command with files" do
      assert Cch.run(~w[README.md], @config) == {:ok}
    end
    test "runs command with filtered files" do
      assert Cch.run(~w[README.md], %{@config | filter: @filter_md}) == {:ok}
    end
    test "runs command with transformed and filtered files" do
      config = %{@config | transforms: [@transform_csv_to_md], filter: @filter_md}
      assert Cch.run(~w[README.csv], config) == {:ok}
    end
  end

  describe "Toolbelt.Cch.config_rspec/0" do
    test "has a command key" do
      assert Cch.config_rspec.command == "rspec"
    end
  end

  describe "Toolbelt.Cch.config_rubocop/0" do
    test "has a command key" do
      assert Cch.config_rubocop.command == "rubocop"
    end
  end

  describe "Toolbelt.Cch.config_haml_lint/0" do
    test "has a command key" do
      assert Cch.config_haml_lint.command == "haml-lint"
    end
  end
end
