defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.User
  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if(conn.assigns[:user]) do
      conn
    else
      conn
      |> put_flash(:error, "You're not logging ! Please click on the logging in link !")
      |> redirect(to: Helpers.topic_path(conn, :index))
      # halt is used to say to controller ok stop here and send the result to the client
      |> halt()
    end
  end
end
