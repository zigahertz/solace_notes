defmodule Solace.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :content, :string

      timestamps()
    end
  end
end
