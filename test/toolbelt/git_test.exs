defmodule Toolbelt.GitTest do
  use ExUnit.Case, async: false
  alias Toolbelt.Git
  doctest Git

  describe "changed_files/0" do
    setup [:emulate_git_repo]

    test "lists changed files", context do
      File.rm("first_file")
      File.write("second_file", "update")
      File.touch("third_file")
      assert Git.changed_files == ~w[first_file second_file third_file]

      System.cmd("git", ~w[add .])
      assert Git.changed_files == ~w[first_file second_file third_file]

      System.cmd("git", ~w[commit -m another_commit])
      assert Git.changed_files == ~w[first_file second_file third_file]

      File.cd(context[:original_dir])
    end
  end

  describe "last_commits/0" do
    setup [:emulate_git_repo]

    test "lists changed files", context do
      File.touch("third_file")
      System.cmd("git", ~w[add .])
      System.cmd("git", ~w[commit -m another_commit])

      [last | [first | []]] = Git.last_commits
      assert last.message == "another_commit"
      assert first.message == "initial_commit"

      File.cd(context[:original_dir])
    end
  end

  describe "set_config/1, get_config/2 and reset_config/1" do
    setup [:emulate_git_repo]

    test "set and get git config", context do
      Git.set_config("toolbelt.test.sport", "football")
      assert Git.get_config("toolbelt.test.sport") == "football"

      Git.reset_config("toolbelt.test")
      assert Git.get_config("toolbelt.test.sport") == nil

      File.cd(context[:original_dir])
    end
  end

  describe "set_global_config/1 and get_global_config/2" do
    test "set and get git config" do
      Git.set_global_config("toolbelt.testglobal.sport", "snowboard")
      assert Git.get_global_config("toolbelt.testglobal.sport") == "snowboard"
    end
  end

  defp emulate_git_repo(_context) do
    folder = "/tmp/git_test"
    File.rm_rf(folder)
    File.mkdir(folder)
    {original_dir, 0} = System.cmd("pwd", [])
    File.cd(folder)
    System.cmd("git", ~w[init])

    File.write("first_file", "first")
    File.write("second_file", "second")

    System.cmd("git", ~w[add .])
    System.cmd("git", ~w[commit -m initial_commit])

    System.cmd("git", ~w[checkout -b my-feature])

    [original_dir: String.trim(original_dir)]
  end
end
