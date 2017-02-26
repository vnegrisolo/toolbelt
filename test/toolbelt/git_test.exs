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

      [last, first] = Git.last_commits
      assert last.message == "another_commit"
      assert first.message == "initial_commit"

      File.cd(context[:original_dir])
    end
  end

  describe "last_commit/0" do
    setup [:emulate_git_repo]

    test "lists changed files", context do
      File.touch("third_file")
      System.cmd("git", ~w[add .])
      System.cmd("git", ~w[commit -m another_commit])

      last = Git.last_commit
      assert last.message == "another_commit"

      File.cd(context[:original_dir])
    end
  end

  describe "config/1, config/2 and reset_config/1" do
    setup [:emulate_git_repo]

    test "set, get and reset git config", context do
      namespace_key = "toolbelt.test"
      key = "#{namespace_key}.sport"

      Git.set_config(key, "climbing")
      assert Git.get_config(key) == "climbing"

      Git.reset_config(namespace_key)
      assert Git.get_config(key) == nil

      File.cd(context[:original_dir])
    end

    test "set, get and reset git config with global flag", context do
      namespace_key = "toolbelt.test"
      key = "#{namespace_key}.sport"

      assert Git.get_config(key, global: true) == nil
      Git.set_config(key, "climbing", global: true)
      assert Git.get_config(key, global: true) == "climbing"

      Git.reset_config(namespace_key, global: true)
      assert Git.get_config(key, global: true) == nil

      File.cd(context[:original_dir])
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
