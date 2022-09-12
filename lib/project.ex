defmodule Bonfire.Data.Projects.Project do
  use Pointers.Pointable,
    otp_app: :bonfire_data_projects,
    table_id: "0D01NGSTVFFST0GETHERG0TEAM",
    source: "bonfire_data_projects_project"

  alias Bonfire.Data.Projects.Project
  alias Ecto.Changeset
  alias Pointers.Pointer

  pointable_schema do
  end

  @cast []

  # @required []

  def changeset(project \\ %Project{}, params) do
    Changeset.cast(project, params, @cast)

    # |> Changeset.validate_required(@required)
    # |> Changeset.assoc_constraint(:verb)
    # |> Changeset.unique_constraint([:subject_id, :verb_id, :object_id])
  end
end

defmodule Bonfire.Data.Projects.Project.Migration do
  use Ecto.Migration
  import Pointers.Migration
  alias Bonfire.Data.Projects.Project

  @project_table Project.__schema__(:source)

  # create_project_table/{0,1}

  defp make_project_table(exprs) do
    quote do
      require Pointers.Migration

      Pointers.Migration.create_pointable_table Bonfire.Data.Projects.Project do
        # Ecto.Migration.add :subject_id,
        #   Pointers.Migration.strong_pointer(), null: false
        (unquote_splicing(exprs))
      end
    end
  end

  defmacro create_project_table(), do: make_project_table([])
  defmacro create_project_table(do: {_, _, body}), do: make_project_table(body)

  # drop_project_table/0

  def drop_project_table(), do: drop_pointable_table(Project)

  # # create_project_subject_index/{0,1}

  # defp make_project_subject_index(opts) do
  #   quote do
  #     Ecto.Migration.create_if_not_exists(
  #       Ecto.Migration.index(unquote(@project_table), [:subject_id], unquote(opts))
  #     )
  #   end
  # end

  # defmacro create_project_subject_index(opts \\ [])
  # defmacro create_project_subject_index(opts), do: make_project_subject_index(opts)

  # def drop_project_subject_index(opts \\ []) do
  #   drop_if_exists(index(@project_table, [:subject_id], opts))
  # end
  # migrate_project/{0,1}

  defp mg(:up) do
    quote do
      unquote(make_project_table([]))

      # unquote(make_project_subject_index([]))
    end
  end

  defp mg(:down) do
    quote do
      # Bonfire.Data.Projects.Project.Migration.drop_project_subject_index()
      Bonfire.Data.Projects.Project.Migration.drop_project_table()
    end
  end

  defmacro migrate_project() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(mg(:up)),
        else: unquote(mg(:down))
    end
  end

  defmacro migrate_project(dir), do: mg(dir)
end
