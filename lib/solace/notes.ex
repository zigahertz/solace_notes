defmodule Solace.Notes do
  import Ecto.Query, warn: false
  alias Solace.Repo

  alias Solace.Notes.Note

  def list_notes do
    Repo.all(Note)
  end

  def list_notes(query) do
    from(n in Note, where: ilike(n.content, ^("%" <> query <> "%"))) |> Repo.all
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  def change_note(%Note{} = note, attrs \\ %{}) do
    Note.changeset(note, attrs)
  end
end
