defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User
  alias Discuss.Router.Helpers

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
  end
end
