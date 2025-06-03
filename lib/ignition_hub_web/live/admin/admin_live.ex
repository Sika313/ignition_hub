defmodule IgnitionHubWeb.AdminLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.USERS
  alias IgnitionHub.TIERS
  alias IgnitionHubWeb.ViewTiersComponent
  def mount(_params, session, socket) do
    case USERS.find_by_token(session["token"]) do
      [] ->
        socket = socket
        |> put_flash(:info, "Login first.")
        |> redirect(to: "/")
        socket
      result ->
        user = for r <- result do
          Map.from_struct(r)
        end
        IO.inspect(user, label: "USER--->")
        socket = socket
        |> assign(:user, Enum.at(user, 0))
        |> assign(:view_tiers, false)
        {:ok, socket}
    end
  end

  def handle_event("close_view_tiers", _params, socket) do
   socket = socket
   |> assign(:view_tiers, false)
   {:noreply, socket}
  end

  def handle_event("handle_add_tier", params, socket) do
    tier = %{
      name: params["name"],
      description: params["description"],
      max_cars: String.to_integer(params["max_cars"])
    }
    TIERS.create_tier(tier)
    socket = socket
    |> put_flash(:info, "Tier added successfully.")
    {:noreply, socket}
  end

  def handle_event("view_tiers", _params, socket) do
    socket = socket
    |> assign(:view_tiers, true)
    {:noreply, socket}
  end

end
