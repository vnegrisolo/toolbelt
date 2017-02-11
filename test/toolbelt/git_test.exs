defmodule Toolbelt.GitTest do
  use ExUnit.Case, async: false
  alias Toolbelt.Git
  doctest Git

  describe "Toolbelt.Git.changed_files/0" do
    setup [:emulate_git_repo]

    test "lists changed files" do
      File.rm("first_file")
      File.write("second_file", "update")
      File.touch("third_file")
      assert Git.changed_files == ~w[first_file second_file third_file]

      System.cmd("git", ~w[add .])
      assert Git.changed_files == ~w[first_file second_file third_file]

      System.cmd("git", ~w[commit -m another_commit])
      assert Git.changed_files == ~w[first_file second_file third_file]
    end
  end

  defp emulate_git_repo(_context) do
    folder = "/tmp/git_test"
    File.rm_rf(folder)
    File.mkdir(folder)
    File.cd(folder)
    System.cmd("git", ~w[init])

    File.write("first_file", "first")
    File.write("second_file", "second")

    System.cmd("git", ~w[add .])
    System.cmd("git", ~w[commit -m initial_commit])

    System.cmd("git", ~w[checkout -b my-feature])
    :ok
  end
end
