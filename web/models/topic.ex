defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field(:title, :string)

    belongs_to(:user, Discuss.User)
    has_many(:comment, Discuss.Comment)
    timestamps()
  end

  # When we want to modify some data
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
