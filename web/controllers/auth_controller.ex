defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    %{"provider" => provider} = params

    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: provider
    }

    #
    # IO.puts("+++++++----------++++++++")
    # IO.inspect(auth)
    # IO.puts("+++++++----------++++++++")

    changeset = Discuss.User.changeset(%Discuss.User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  # All the logic for signin a user
  defp signin(conn, changeset) do
    #
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Authenticated successfully !")
        |> put_flash(:info, "Welcome back !")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))

      {:error, reason} ->
        IO.puts("+++++++----------++++++++")
        IO.inspect(reason)
        IO.puts("+++++++----------++++++++")

        conn
        |> put_flash(:error, "Error signin in !")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
