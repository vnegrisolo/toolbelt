defmodule Toolbelt.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      test_coverage: [tool: ExCoveralls],
   ]
  end

  defp deps do
    [
      {:credo,       "~> 0.5",   only: [:dev, :test]},
      {:earmark,     "~> 1.0.0", only: :dev},
      {:ex_doc,      "~> 0.14",  only: :dev},
      {:excoveralls, "~> 0.6",   only: :test},
    ]
  end
end
