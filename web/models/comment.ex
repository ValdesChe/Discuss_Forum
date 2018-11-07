defmodule Discuss.Comment do
  use Discuss.Web, :model
  # Tell to poison that it only have to convert into json is :content field
  @derive {Poison.Encoder, only: [:content, :user]}
  schema "comments" do
    field(:content, :string)
    belongs_to(:topic, Discuss.Topic)
    belongs_to(:user, Discuss.User)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
