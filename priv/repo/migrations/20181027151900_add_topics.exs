defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      field(:title, :string)
    end
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
