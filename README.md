# Personnummer
Validate Swedish social security numbers.
[![Build Status](https://travis-ci.org/brolaugh/personnummer-elixir.svg?branch=master)](https://travis-ci.org/brolaugh/personnummer-elixir)[![Coverage Status](https://coveralls.io/repos/github/brolaugh/personnummer-elixir/badge.svg?branch=master)](https://coveralls.io/github/brolaugh/personnummer-elixir?branch=master)
## Installation

The package can be installed
by adding `personnummer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:personnummer, "~> 0.1.0"}
  ]
end
```

## Example

```elixir
iex> Personnummer.valid?(6403273813)
true
iex> Personnummer.valid?("19130401+2931")
true
```

## Documentation
The docs can be found at [https://hexdocs.pm/personnummer](https://hexdocs.pm/personnummer).

