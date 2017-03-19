use Mix.Config

config :tb_cch, [
  run: %{
    haml_lint: %{
      command: "haml-lint",
      filter: ~r/\.haml$/
    },
    rspec: %{
      command: "rspec",
      transforms: [
        {~r/^app\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/\\1_spec.rb"},
        {~r/^lib\/(.+)\.rb$/, "spec/lib/\\1_spec.rb"}
      ],
      filter: ~r/_spec\.rb$/
    },
    rubocop: %{
      command: "rubocop",
      filter: ~r/\.rb$/
    },
  }
]

import_config "#{Mix.env}.exs"
