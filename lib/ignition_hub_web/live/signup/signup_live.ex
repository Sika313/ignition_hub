defmodule IgnitionHubWeb.SignupLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.CLIENTS

  def mount(_params, session, socket) do
    {:ok, socket}
  end

  def handle_event("submit", params, socket) do
    if params["password"] != params["confirm-password"] do
      IO.inspect("HIT--->")
      socket = socket
      |> put_flash(:error, "Passwords to not match")
      {:noreply, socket}
    else
      
      data = %{
        fname: params["fname"],
        lname: params["lname"],
        gender: params["gender"],
        password: params["password"],
        phone: params["phone"],
        token: UUID.uuid4(),
      }
      case CLIENTS.create_client(data) do
        {:ok, _} ->
          socket = socket
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: "/login")
          {:noreply, socket}
        {:error, _} ->
          socket = socket
          |> put_flash(:error, "An error occured, contact tech support.")
          {:noreply, socket}
      end
    end
  end


end
