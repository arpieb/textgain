defmodule Textgain.Mixfile do
  use Mix.Project

  def project do
    [
      app: :textgain,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs.
      name: "Textgain",
      source_url: "https://bitbucket.org/arpieb/textgain",
      homepage_url: "https://bitbucket.org/arpieb/textgain",
      docs: [
        main: "readme",
        extras: [
          "README.md",
        ]
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [
        :logger,
        :httpoison,
        :poison,
      ]
    ]
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
      {:ex_doc, "~> 0.14.5", only: :dev},
      {:httpoison, "~> 0.10.0"},
      {:poison, "~> 3.0"},
    ]
  end
end
