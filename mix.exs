defmodule Textgain.Mixfile do
  use Mix.Project

  def project do
    [
      app: :textgain,
      version: "0.1.2",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
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

  def application do
    [
      applications: [
        :logger,
        :httpoison,
        :poison,
      ]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14.5", only: :dev},
      {:httpoison, "~> 0.10.0"},
      {:poison, "~> 3.0"},
    ]
  end

  defp description do
    """
    This module provides access to the various natural language processing (NLP) text analytics services provided by Textgain.
    """
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*",
      ],
      maintainers: ["Robert Bates"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/arpieb/textgain",
        "Textgain" => "https://www.textgain.com/",
      },
    ]
  end
end
