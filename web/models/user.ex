defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)

    timestamps()
  end

  # When we want to modify some data
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end