defmodule Hexdocset.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hexdocset,
      version: "1.0.1",
      name: "Hexdocset",
      description: "Convert hex doc to Dash.app's docset format.",
      package: package,
      source_url: "https://github.com/yesmeck/hexdocset",
      escript: escript_config,
      elixir: "~> 1.0",
      deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
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
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:floki, "~> 0.0.5"}
    ]
  end

  def escript_config do
    [ main_module: Hexdocset.CLI ]
  end

  def package do
    [
      contributors: ["Wei Zhu"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/yesmeck/hexdocset"}
    ]
  end
end
