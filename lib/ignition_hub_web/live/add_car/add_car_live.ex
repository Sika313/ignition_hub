defmodule IgnitionHubWeb.AddCarLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.CLIENTS
  alias IgnitionHub.CARS

  def mount(_params, session, socket) do
    case CLIENTS.find_by_token(session["token"]) do
      {:ok, result} ->
        result_map = Map.from_struct(result)
        socket = socket
        |> assign(:client, result_map)
        |> assign(:uploaded_files, [])
        |> allow_upload(:avatar, accept: ~w(.jpg), max_entries: 4)
        {:ok, socket}
      nil ->
        socket = socket
        |> put_flash(:error, "You must login first.")
        |> redirect(to: "/")
        socket
    end
  end

  def handle_event("save", params, socket) do
  IO.inspect(params, label: "PARAMS--->")
  uploaded_files =
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join(Application.app_dir(:ignition_hub, "priv/static/images/uploads"), Path.basename(path))
      # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
      File.cp!(path, dest <> ".jpg")
      file_name = String.splitter(dest, "/") |> Enum.take(-1)
      full_file_name = Enum.at(file_name, 0) <> ".jpg"

     data_car = %{
     engine_size: params["engine_size"],
     engine_type: params["engine_type"],
     make: params["make"],
     model: params["model"],
     price: params["price"],
     transmission: params["transmission"],
     year: params["year"],
     pic_one: full_file_name,
     client_id: socket.assigns.client.id 
    }
    IO.inspect(data_car)
    CARS.create_car(data_car)
    {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)
    
    socket = socket
    |> put_flash(:info, "Car has been added successfully.")
    |> redirect(to: "/client")
    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

end
