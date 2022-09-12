Code.eval_file("mess.exs")

defmodule Bonfire.Data.Projects.MixProject do
  use Mix.Project

  def project do
    [
      app: :bonfire_data_projects,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "Projects",
      homepage_url: "https://github.com/bonfire-networks/bonfire_data_projects",
      source_url: "https://github.com/bonfire-networks/bonfire_data_projects",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" =>
            "https://github.com/bonfire-networks/bonfire_data_projects",
          "Hexdocs" => "https://hexdocs.pm/bonfire_data_projects"
        }
      ],
      docs: [
        # The first page to display from the docs
        main: "readme",
        # extra pages to include
        extras: ["README.md"]
      ],
      deps: Mess.deps([{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}])
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
