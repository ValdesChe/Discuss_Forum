defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field(:title, :string)
  end

  # When we want to modify some data
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
