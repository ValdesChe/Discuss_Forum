defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User
  # alias Discuss.Router.Helpers

  @doc """
      Called one time.
  """
  def init(_params) do
  end

  @doc """
      Called anytime the plug runs.
      This 'call' function takes two necesssary params : `conn` and `_params`
      `call` Takes a connection (`conn`) and return a connection
      `params` is value returned by `Init` function.
  """
  def call(conn, _params) do
    # We retrieve the user's info from session store
    user_id = get_session(conn, :user_id)

    # The assign function used here take a connection, modify the assign prop
    # and then return a connection ( conn )
    cond do
      # Return the user from database if the user_id is defined
      user = user_id && Repo.get(User, user_id) ->
        # Modify our assigns prop in the conn Struct
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
