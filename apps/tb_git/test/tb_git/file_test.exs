defmodule TBGit.FileTest do
  use ExUnit.Case, async: false
  doctest File

  describe "changed/0" do
    setup [:emulate_git_repo]

    test "lists changed files", %{original_dir: original_dir} do
      File.rm("first_file")
      File.write("second_file", "update")
      File.touch("third_file")
      assert TBGit.File.changed == ~w[first_file second_file third_file]

      System.cmd("git", ~w[add .])
      assert TBGit.File.changed == ~w[first_file second_file third_file]

      System.cmd("git", ~w[commit -m another_commit])
      assert TBGit.File.changed == ~w[first_file second_file third_file]

      File.cd(original_dir)
    end
  end

  defp emulate_git_repo(_context) do
    folder = "/tmp/test-#{__MODULE__}"
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

    %{original_dir: String.trim(original_dir)}
  end
end
