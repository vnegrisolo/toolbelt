defmodule Toolbelt.Mixfile do
  use Mix.Project

  def project do
    [
      app: :toolbelt,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        extras: ["README.md"],
        main: "README"
      ],
      test_coverage: [tool: ExCoveralls],
      escript: [main_module: Toolbelt],
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:apex, "~>1.0.0", only: [:dev, :test]},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:earmark, "~> 1.0.0", only: :dev},
      {:excoveralls, "~> 0.6", only: :test},
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end
end
