defmodule LiveEventsWeb.UserLive do
  use Phoenix.LiveView

  alias LiveEventsWeb.UserLive
  alias LiveEventsWeb.Router.Helpers, as: Routes
  alias LiveEvents.Account

  def mount(%{id: id}, socket) do
    user = Account.get_user!(id)

    {:ok,
     assign(socket, %{
       accolades: [%{name: "name-#{:rand.uniform(1000)}"}],
       user: user,
       changeset: Account.change_user(user)
     })}
  end

  def render(assigns), do: LiveEventsWeb.UserView.render("edit.html", assigns)

  def handle_event("validate_owner", params, socket) do
    {:noreply, socket}
  end

  def handle_event("add_accolade", _, socket) do
    accolades = socket.assigns.accolades
    accolades = [%{name: "name-#{:rand.uniform(1000)}"} | accolades]
    {:noreply, assign(socket, %{accolades: accolades})}
  end

  def handle_event("remove_accolade", _, socket) do
    case socket.assigns.accolades do
      [] -> {:noreply, assign(socket, %{accolades: []})}
      [_h | t] -> {:noreply, assign(socket, %{accolades: t})}
    end
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Account.update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        {:stop,
         socket
         |> put_flash(:info, "User updated successfully.")
         |> redirect(to: Routes.user_path(socket, :show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
