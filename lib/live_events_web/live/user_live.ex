defmodule LiveEventsWeb.UserLive do
  use Phoenix.LiveView

  alias LiveEventsWeb.UserLive
  alias LiveEventsWeb.Router.Helpers, as: Routes
  alias LiveEvents.Account

  def mount(%{id: id}, socket) do
    user = Account.get_user!(id)

    {:ok,
     assign(socket, %{
       accolades: [
         %{id: :rand.uniform(1000), name: "name-#{:rand.uniform(1000)}"},
         %{id: :rand.uniform(1000), name: "name-#{:rand.uniform(1000)}"},
         %{id: :rand.uniform(1000), name: "name-#{:rand.uniform(1000)}"}
       ],
       user: user,
       changeset: Account.change_user(user)
     })}
  end

  def render(assigns), do: LiveEventsWeb.UserView.render("edit.html", assigns)

  def handle_event("validate_owner", params, socket) do
    {:noreply, socket}
  end

  def handle_event("validate_accolade", _, socket) do
    {:noreply, socket}
  end

  def handle_event("add_accolade", _, socket) do
    accolades = socket.assigns.accolades
    accolades = accolades ++ [%{id: :rand.uniform(1000), name: "name-#{:rand.uniform(1000)}"}]
    {:noreply, assign(socket, %{accolades: accolades})}
  end

  def handle_event("remove_accolade", %{"id" => id}, socket) do
    accolades = remove_accolade(socket.assigns.accolades, String.to_integer(id))
    {:noreply, assign(socket, %{accolades: accolades})}
  end

  defp remove_accolade([]), do: []
  defp remove_accolade(accolades, id) do
    Enum.filter(accolades, fn ac -> ac.id != id end)
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
