defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add(:user_id, references(:users))
      timestamps()
    end
  end
end
