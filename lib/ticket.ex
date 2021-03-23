defmodule Bonfire.Data.Projects.Ticket do
  use Pointers.Pointable,
    otp_app: :bonfire_data_projects,
    table_id: "7HEVN1T0FSTVFFNEED1NGD0NES",
    source: "bonfire_data_projects_ticket"

  alias Bonfire.Data.Projects.Ticket
  alias Ecto.Changeset
  alias Pointers.Pointer

  pointable_schema do
  end

  @cast     []
  # @required []

  def changeset(ticket \\ %Ticket{}, params) do
    ticket
    |> Changeset.cast(params, @cast)
    # |> Changeset.validate_required(@required)
    # |> Changeset.assoc_constraint(:verb)
    # |> Changeset.unique_constraint([:subject_id, :verb_id, :object_id])
  end

end
defmodule Bonfire.Data.Projects.Ticket.Migration do

  use Ecto.Migration
  import Pointers.Migration
  alias Bonfire.Data.Projects.Ticket

  @ticket_table Ticket.__schema__(:source)

  # create_ticket_table/{0,1}

  defp make_ticket_table(exprs) do
    quote do
      require Pointers.Migration
      Pointers.Migration.create_pointable_table(Bonfire.Data.Projects.Ticket) do
        # Ecto.Migration.add :subject_id,
        #   Pointers.Migration.strong_pointer(), null: false
        unquote_splicing(exprs)
      end
    end
  end

  defmacro create_ticket_table(), do: make_ticket_table([])
  defmacro create_ticket_table([do: {_, _, body}]), do: make_ticket_table(body)

  # drop_ticket_table/0

  def drop_ticket_table(), do: drop_pointable_table(Ticket)

  # # create_ticket_subject_index/{0,1}

  # defp make_ticket_subject_index(opts) do
  #   quote do
  #     Ecto.Migration.create_if_not_exists(
  #       Ecto.Migration.index(unquote(@ticket_table), [:subject_id], unquote(opts))
  #     )
  #   end
  # end


  # defmacro create_ticket_subject_index(opts \\ [])
  # defmacro create_ticket_subject_index(opts), do: make_ticket_subject_index(opts)

  # def drop_ticket_subject_index(opts \\ []) do
  #   drop_if_exists(index(@ticket_table, [:subject_id], opts))
  # end

  # migrate_ticket/{0,1}

  defp mt(:up) do
    quote do
      unquote(make_ticket_table([]))
      # unquote(make_ticket_subject_index([]))
    end
  end
  defp mt(:down) do
    quote do
      # Bonfire.Data.Projects.Ticket.Migration.drop_ticket_subject_index()
      Bonfire.Data.Projects.Ticket.Migration.drop_ticket_table()
    end
  end

  defmacro migrate_ticket() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(mt(:up)),
        else: unquote(mt(:down))
    end
  end

  defmacro migrate_ticket(dir), do: mt(dir)

end
