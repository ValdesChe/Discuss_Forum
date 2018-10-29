defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  def new(conn, params) do
    # struct = %Discuss.Topic{}
    # params = %{}

    # changeset = Discuss.Topic.changeset(struct, params)
    changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    IO.puts("+++++++-----------++++++++++")
    IO.inspect(conn)
    IO.puts("+++++++-----------++++++++++")
    IO.inspect(params)
    IO.puts("+++++++-----------++++++++++")
    conn
  end
end
