defmodule TBGit.CommitTest do
  use ExUnit.Case, async: false
  alias TBGit.Commit
  alias TBGit.Author
  doctest Commit

  describe "last_commits/0" do
    setup [:emulate_git_repo]

    test "last 10 commits", %{original_dir: original_dir} do
      commits = Commit.last_commits
                |> Enum.map(&(Map.put(&1, :sha, nil)))
      assert commits == [
        %Commit{
          author: %Author{
            email: "second_author_email"
          },
          committer: %Author{
            email: "second_committer_email"
          },
          message: "second_commit"
        },
        %Commit{
          author: %Author{
            email: "first_author_email"
          },
          committer: %Author{
            email: "first_committer_email"
          },
          message: "first_commit"
        }
      ]

      File.cd(original_dir)
    end
  end

  describe "last_commit/0" do
    setup [:emulate_git_repo]

    test "last commit", %{original_dir: original_dir} do
      commit = Commit.last_commit
               |> Map.put(:sha, nil)

      assert commit == %Commit{
        author: %Author{
          email: "second_author_email"
        },
        committer: %Author{
          email: "second_committer_email"
        },
        message: "second_commit"
      }

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

    File.touch("first_file")
    System.cmd("git", ~w[add .])
    System.cmd("git", ~w[commit -m first_commit], env: [
      {"GIT_AUTHOR_NAME",     "first_author_name"},
      {"GIT_AUTHOR_EMAIL",    "first_author_email"},
      {"GIT_COMMITTER_NAME",  "first_committer_name"},
      {"GIT_COMMITTER_EMAIL", "first_committer_email"}
    ])

    File.touch("second_file")
    System.cmd("git", ~w[add .])
    System.cmd("git", ~w[commit -m second_commit], env: [
      {"GIT_AUTHOR_NAME",     "second_author_name"},
      {"GIT_AUTHOR_EMAIL",    "second_author_email"},
      {"GIT_COMMITTER_NAME",  "second_committer_name"},
      {"GIT_COMMITTER_EMAIL", "second_committer_email"}
    ])

    %{original_dir: String.trim(original_dir)}
  end
end
