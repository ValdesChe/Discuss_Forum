defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)

  def callback(conn, params) do
    IO.puts("1.. -------")
    IO.inspect(conn.assigns)
    IO.puts("**------------******.. -------")
    IO.puts("2.. -------")
    IO.inspect(params)
    IO.puts("**------------******.. -------")
    conn
  end
end
