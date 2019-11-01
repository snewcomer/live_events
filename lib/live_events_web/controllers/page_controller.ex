defmodule LiveEventsWeb.PageController do
  use LiveEventsWeb, :controller

  alias LiveEvents.Account

  def index(conn, _params) do
    user = Account.get_user!(1)

    render(conn, "index.html", user: user)
  end
end
