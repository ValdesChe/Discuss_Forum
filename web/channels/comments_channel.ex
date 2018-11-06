defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  # anytime a JS CLient join the channel
  # name  = "comments:#id#"
  def join("comments:" <> topic_id, _params, socket) do
    #
    topic_id = String.to_integer(topic_id)
    topic = Discuss.Repo.get(Topic, topic_id)

    IO.puts("***** Join *******")
    IO.inspect(topic)
    IO.puts("************")

    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    IO.puts("***** Handle *******")

    topic = socket.assigns[:topic]

    changeset =
      topic
      |> build_assoc(:comment)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        IO.puts("********--------------------**********")
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
