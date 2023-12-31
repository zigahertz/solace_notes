defmodule Solace.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Solace.Notes` context.
  """

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        content: "content for my note goes here"
      })
      |> Solace.Notes.create_note()

    note
  end
end
