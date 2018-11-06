defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  # anytime a JS CLient join the channel
  def join(name, _params, socket) do
    #
    IO.puts("1: ++++++++++++++++++++")
    IO.puts(name)
    IO.puts("2: ++++++++++++++++++++")
    {:ok, %{}, socket}
  end

  def handle_in(socket) do
    #
  end
end
