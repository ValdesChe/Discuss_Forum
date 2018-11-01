defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_auth: auth}}, params) do
    IO.puts("----------**********-------------")
    IO.inspect(auth)
    IO.puts("----------**********-------------")

    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: auth.provider
    }

    changeset = Discuss.User.changeset(%{}, user_params)

    #
    record = insert_or_update(changeset)
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
