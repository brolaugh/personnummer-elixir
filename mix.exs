defmodule Personnummer.MixProject do
  use Mix.Project

  def project do
    [
      app: :personnummer,
      version: "0.2.0",
      elixir: "~> 1.3",
      description: "Validate swedish social security numbers",
      package: [
        maintainers: ["Hannes Kindströmmer"],
        licenses: ["MIT"],
        links: %{"Github" => "https://github.com/brolaugh/personnummer-elixir"}
      ],
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.3", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:luhn, "~> 0.3"}
    ]
  end
end
