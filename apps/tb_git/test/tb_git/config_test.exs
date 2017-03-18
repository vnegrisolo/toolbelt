defmodule TBGit.ConfigTest do
  use ExUnit.Case, async: false
  alias TBGit.Config
  doctest Config

  describe "get/1, set/2 and reset/1" do
    setup [:emulate_git_repo]

    test "set, get and reset git config", %{original_dir: original_dir} do
      config = %Config{namespace: __MODULE__, key: "sport"}

      assert Config.set(config, "climbing") == {:ok}
      assert Config.get(config) == "climbing"

      assert Config.reset(config) == {:ok}
      assert Config.get(config) == nil

      File.cd(original_dir)
    end

    test "set, get and reset git config with global flag", %{original_dir: original_dir} do
      config = %Config{namespace: __MODULE__, key: "sport", global: true}

      assert Config.set(config, "climbing") == {:ok}
      assert Config.get(config) == "climbing"

      assert Config.reset(config) == {:ok}
      assert Config.get(config) == nil

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

    [original_dir: String.trim(original_dir)]
  end
end
