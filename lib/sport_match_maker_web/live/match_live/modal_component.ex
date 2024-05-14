
defmodule SportMatchMakerWeb.MatchLive.ModalComponent do
  use SportMatchMakerWeb, :live_component

  alias SportMatchMaker.Matches

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-lg">
      <.header><%= @title %></.header>
      <figure class= "relative w-full rounded-xl p-4 transition-all bg-neutral-50-50 border-gray-200 text-zinc-500 dark:border-gray-50 dark:bg-gray-50">
        <div class="flex justify-center gap-6">
          <img class="rounded-full" width="256" height="256" alt="" src={"https://picsum.photos/id/#{@user.id}/256"} />
          <div class="flex flex-col">
            <p class="text-xs font-medium dark:text-zinc-700">
               <%= gettext("Email") %>
            </p>
            <figcaption class="text-lg font-medium text-black">
              <%= @user.email %>
            </figcaption>

            <p class="text-xs mt-2 font-medium dark:text-zinc-700">
              <%= gettext("Skill level") %>
            </p>
            <figcaption class="text-lg font-medium text-black">
              <%= @user.profile.skill_level %>
            </figcaption>

            <p class="text-xs mt-2 font-medium dark:text-zinc-700">
              <%= gettext("Game style/format") %>
            </p>
            <figcaption class="text-lg font-medium text-black">
              <%= @user.profile.game_style_preference %> / <%= @user.profile.game_format_preference %>
            </figcaption>

            <p class="text-xs mt-2 font-medium dark:text-zinc-700">
              <%= gettext("Borough") %>
            </p>
            <figcaption class="text-lg font-medium text-black">
              <%= @user.profile.borough %>
            </figcaption>

            <p class="text-xs mt-2 font-medium dark:text-zinc-700">
              <%= gettext("Game time") %>
            </p>
            <figcaption class="text-lg font-medium text-black">
              <%= Calendar.strftime(@user.profile.game_time_preference, "%Y-%m-%d %H:%M:%S") %>
            </figcaption>
          </div>
        </div>
        <div class="mt-12 flex justify-center">
          <.button class="bg-brand/80 hover:bg-brand/90" phx-click={JS.push("save", target: @myself)}>
            <%= gettext("Confirm match") %>
          </.button>
        </div>
      </figure>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def handle_event("save", _params, socket) do
    save_match(socket, socket.assigns.action, socket.assigns.user)
  end

  defp save_match(socket, :new_match, user) do
    case Matches.create_match(socket.assigns.scope, user) do
      {:ok, _match} ->
        {:noreply,
         socket
         |> put_flash(:info, gettext("Successfully matched"))
         |> push_patch(to: socket.assigns.patch)}

      {:error, _} ->
        {:noreply, socket}
    end
  end
end
