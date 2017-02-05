defmodule Toolbelt.GitTest do
  use ExUnit.Case, async: true
  doctest Toolbelt.Git
  alias Toolbelt.Git

  describe "Toolbelt.Git.changed_files/0" do
    setup [:emulate_git_repo]

    test "non staged files should be listed as a changed file" do
      File.rm("first_file")
      File.write("second_file", "update")
      File.touch("third_file")
      assert Git.changed_files == ["first_file", "second_file", "third_file"]

      System.cmd("git", ["add", "."])
      assert Git.changed_files == ["first_file", "second_file", "third_file"]

      System.cmd("git", ["commit", "-m", "Another Commit"])
      assert Git.changed_files == ["first_file", "second_file", "third_file"]
    end
  end

  defp emulate_git_repo(_context) do
    folder = "/tmp/git_test"
    File.rm_rf(folder)
    File.mkdir(folder)
    File.cd(folder)
    System.cmd("git", ["init"])

    File.write("first_file", "first")
    File.write("second_file", "second")

    System.cmd("git", ["add", "."])
    System.cmd("git", ["commit", "-m", "Initial Commit"])

    System.cmd("git", ["checkout", "-b", "my-feature"])
    :ok
  end
end
