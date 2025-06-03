defmodule IgnitionHubWeb.ViewTiersComponent do
  use IgnitionHubWeb, :live_component
  alias IgnitionHub.TIERS

  def update(assigns, socket) do
    tiers = TIERS.list_tiers()
    tiers = for tier <- tiers do
      Map.from_struct(tier)
    end

    socket = socket
    |> assign(:tiers, tiers)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <button class="bg-blue-500 text-white" phx-click="close_view_tiers">Close</button>
      <%= if @tiers == [] do %>
        <h1> No tier found </h1>
      <% else %>
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                   Name
                </th>
                <th scope="col" class="px-6 py-3">
                  Description 
                </th>
                <th scope="col" class="px-6 py-3">
                  Maximum car uploads allowed 
                </th>
            </tr>

        </thead>
        <tbody>
          <%= for tier <- @tiers do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= tier.name %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= tier.description %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= tier.max_cars %> 
                </th>
            </tr>

          <% end %>
      </tbody>
    
    </table>
    <% end %>
      </div>

    """
  end

end
