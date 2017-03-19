defmodule TbCch.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tb_cch,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      aliases: aliases(),
      escript: escript(),
   ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:earmark, "~> 1.0.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev},
      {:excoveralls, "~> 0.6", only: :test},
      {:tb_git, in_umbrella: true},
      {:tb_system, in_umbrella: true},
    ]
  end

  defp escript do
    [
      main_module: TbCch.CLI
    ]
  end

  defp aliases do
    [
      d: [
        "deps.get",
        "compile",
        "credo",
        "dialyzer",
        "docs",
      ],
      t: [
        "test --trace",
        "coveralls.html",
      ],
      p: [
        "escript.build"
      ]
    ]
  end
end
