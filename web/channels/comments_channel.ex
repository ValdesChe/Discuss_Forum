defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  # anytime a JS CLient join the channel
  # name  = "comments:#id#"
  def join("comments:" <> topic_id, _params, socket) do
    #
    topic_id = String.to_integer(topic_id)

    topic =
      Topic
      |> Discuss.Repo.get(topic_id)
      # |> Discuss.Repo.preload(comments: from(c in Comment, order_by: c.inserted_at))
      |> Discuss.Repo.preload(comments: [:user])

    IO.puts("***** Join *******")
    IO.inspect(topic)
    IO.puts("************")

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns[:topic]
    user_id = socket.assigns.user_id

    changeset =
      topic
      |> build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        # Now we notify the changes to every users via broadcast method
        # ! is for logging error if something goes wrong
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      # socket = Map.put_new(socket.assign, arg2, arg3)
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

    #
    #   _ ->
    #     {:reply, :ok, socket}
    # end
  end
end
