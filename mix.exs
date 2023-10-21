defmodule LinkMe.MixProject do
  use Mix.Project

  def project do
    [
      app: :link_me,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LinkMe, []},
      extra_applications: [:logger, :plug_cowboy, :inets, :logger_file_backend, :tzdata]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
        {:tzdata, "~> 1.0"},
        {:plug_cowboy, "~> 2.0"},
        {:poison, "~> 3.0", override: true},
        {:html_handler, git: "https://github.com/gregoire-riviere/html_handler.git", tag: "v1.0.2"},
        {:logger_file_backend, "~> 0.0.10"},
        {:timex, "~> 3.5"},
        {:gen_smtp, "~> 1.2.0"}
    ]
  end
end
