defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  # anytime a JS CLient join the channel
  def join(name, _params, socket) do
    #
    {:ok, %{hey: "There"}, socket}
  end

  def handle_in(name, message, socket) do
    #

    IO.puts("++++++++++++++++++++")
    IO.puts(name)
    IO.inspect(message)
    IO.inspect(socket)

    IO.puts(" ++++++++++++++++++++")

    {:reply, :ok, socket}
  end
end
