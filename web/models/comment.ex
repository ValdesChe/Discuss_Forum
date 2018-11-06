defmodule Discuss.Comment do
  use Discuss.Web, :model

  schema "comments" do
    field(:content, :string)
    belongs_to(:users, Discuss.User)
    belongs_to(:topics, Discuss.Topic)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
