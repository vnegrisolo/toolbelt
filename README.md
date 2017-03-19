# Toolbelt

This is my **toolbelt** project.

## Useful Commands

To be run in the **umbrella project**:

| Command                                         | Description         |
| --------------------------------------------    | ------------------- |
| `mix credo`                                     | style code analysis |
| `mix dialyzer`                                  | BEAM code analysis  |
| `mix docs`                                      | generate docs       |
| `mix test --trace`                              | run tests           |
| `MIX_ENV=test mix coveralls.html --umbrella`    | test coverage       |

To be run in the **individuals project**:

| Command                                         | Description         |
| --------------------------------------------    | ------------------- |
| `mix credo`                                     | style code analysis |
| `mix dialyzer`                                  | BEAM code analysis  |
| `mix docs`                                      | generate docs       |
| `mix test --trace`                              | run tests           |
| `MIX_ENV=test mix coveralls.html`               | test coverage       |

To generate scripts:

```shell
cd apps/tb_cch
MIX_ENV=prod mix escript.build
```

For just being short there are these mix aliases based on `MIX_ENV` to be used:

| Command              | Description         |
| -------------------- | ------------------- |
| `mix d`              | credo/dialyzer/docs |
| `MIX_ENV=test mix t` | test/coveralls      |
| `MIX_ENV=prod mix p` | escript             |

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `toolbelt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:toolbelt, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/toolbelt](https://hexdocs.pm/toolbelt).
