defmodule Bonfire.Data.Projects.Repo do
  use Pointers.Pointable,
    otp_app: :bonfire_data_projects,
    table_id: "7HEP1ACETHEYKEEPS0VRCEC0DE",
    source: "bonfire_data_projects_repo"

  alias Bonfire.Data.Projects.Repo
  alias Ecto.Changeset
  alias Pointers.Pointer

  pointable_schema do
  end

  @cast []

  # @required []

  def changeset(repo \\ %Repo{}, params) do
    Changeset.cast(repo, params, @cast)

    # |> Changeset.validate_required(@required)
    # |> Changeset.assoc_constraint(:verb)
    # |> Changeset.unique_constraint([:subject_id, :verb_id, :object_id])
  end
end

defmodule Bonfire.Data.Projects.Repo.Migration do
  use Ecto.Migration
  import Pointers.Migration
  alias Bonfire.Data.Projects.Repo

  @repo_table Repo.__schema__(:source)

  # create_repo_table/{0,1}

  defp make_repo_table(exprs) do
    quote do
      require Pointers.Migration

      Pointers.Migration.create_pointable_table Bonfire.Data.Projects.Repo do
        # Ecto.Migration.add :subject_id,
        #   Pointers.Migration.strong_pointer(), null: false
        (unquote_splicing(exprs))
      end
    end
  end

  defmacro create_repo_table(), do: make_repo_table([])
  defmacro create_repo_table(do: {_, _, body}), do: make_repo_table(body)

  # drop_repo_table/0

  def drop_repo_table(), do: drop_pointable_table(Repo)

  # # create_repo_subject_index/{0,1}

  # defp make_repo_subject_index(opts) do
  #   quote do
  #     Ecto.Migration.create_if_not_exists(
  #       Ecto.Migration.index(unquote(@repo_table), [:subject_id], unquote(opts))
  #     )
  #   end
  # end

  # defmacro create_repo_subject_index(opts \\ [])
  # defmacro create_repo_subject_index(opts), do: make_repo_subject_index(opts)

  # def drop_repo_subject_index(opts \\ []) do
  #   drop_if_exists(index(@repo_table, [:subject_id], opts))
  # end
  # migrate_repo/{0,1}

  defp mt(:up) do
    quote do
      unquote(make_repo_table([]))

      # unquote(make_repo_subject_index([]))
    end
  end

  defp mt(:down) do
    quote do
      # Bonfire.Data.Projects.Repo.Migration.drop_repo_subject_index()
      Bonfire.Data.Projects.Repo.Migration.drop_repo_table()
    end
  end

  defmacro migrate_repo() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(mt(:up)),
        else: unquote(mt(:down))
    end
  end

  defmacro migrate_repo(dir), do: mt(dir)
end
