defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  def index(conn, _params) do
    topics = Repo.all(Discuss.Topic)

    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    # struct = %Discuss.Topic{}
    # params = %{}

    # changeset = Discuss.Topic.changeset(struct, params)
    changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Discuss.Topic.changeset(%Discuss.Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created successfully !")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "OuPs ! Something went wrong ..")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Discuss.Topic, topic_id)
    changeset = Discuss.Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Discuss.Topic, topic_id)

    changeset =
      old_topic
      |> Discuss.Topic.changeset(topic)

    IO.inspect(topic)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic updated correctly !")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "OuPs ! Something went wrong during update ...")
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Discuss.Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic has been deleted .")
    |> redirect(to: topic_path(conn, :index))
  end
end
