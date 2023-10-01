defmodule Solace.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> validate_length(:content, min: 20, max: 300)
  end
end
