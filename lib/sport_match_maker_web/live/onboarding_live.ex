defmodule SportMatchMakerWeb.OnboardingLive do
  use SportMatchMakerWeb, :live_view

  alias SportMatchMaker.Accounts.Profile

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-lg">
      <.header class="text-center">
        <span class={["bg-gradient-to-r from-orange-200 to-orange-600", "bg-clip-text text-transparent", "text-4xl font-bold"]}>
          SportMatchMaker
        </span>
        <:subtitle>
          <%= gettext("Slogan") %>
        </:subtitle>
      </.header>
      <div class="flex justify-around">
        <div class="w-full sm:w-auto">
          <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-3">
            <.button phx-click={show_modal("how-it-works-modal")} class="group relative bg-transparent transition bg-transparent rounded-md px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6">
              <span class="absolute inset-0 rounded-md bg-zinc-50 transition group-hover:bg-zinc-100">
              </span>
              <span class="relative flex items-center gap-4 sm:flex-col">
                <.icon name="hero-information-circle" class="h-6 w-6" />
                <%= gettext("How it works") %>
              </span>
            </.button>
            <.button phx-click={show_modal("cities-modal")} class="group relative bg-transparent transition bg-transparent rounded-md px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6">
              <span class="absolute inset-0 rounded-md bg-zinc-50 transition group-hover:bg-zinc-100">
              </span>
              <span class="relative flex items-center gap-4 sm:flex-col">
              <.icon name="hero-map-pin" class="h-6 w-6" />
                <%= gettext("Cities") %>
              </span>
            </.button>
            <.button phx-click={show_modal("sports-modal")} class="group relative bg-transparent transition bg-transparent rounded-md px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6">
              <span class="absolute inset-0 rounded-md bg-zinc-50 transition group-hover:bg-zinc-100">
              </span>
              <span class="relative flex items-center gap-4 sm:flex-col">
                <.icon name="hero-trophy" class="h-6 w-6" />
                <%= gettext("Sports") %>
              </span>
            </.button>
          </div>
        </div>
      </div>
      <.simple_form
        for={@form}
        id="onboarding_profile_form"
        phx-submit="open_registration_modal"
        phx-change="validate"
      >
        <.error :if={@check_errors}>
          <%= gettext("Oops, something went wrong! Please check the errors below.") %>
        </.error>

        <div class="flex">
          <div class="w-full sm:w-auto">
            <div class="mt-5 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
              <div class="cols-span-1 group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6">
                <span class="absolute inset-0 rounded-2xl bg-red-50 transition group-hover:bg-red-100 sm:group-hover:scale-105">
                </span>
                <span class="relative flex items-center gap-4 mb-7 text-lg text-rose-600 sm:flex-row">
                  <.icon name="hero-user-solid" class="h-6 w-6 place-self-center" />
                  <%= gettext("Personal details") %>
                </span>
                <span class="relative flex-auto items-start space-y-4 sm:flex-col">
                  <.input field={@form[:age_group]} type="select" label={gettext("Age")} prompt={gettext("Select age")} options={age_groups()} required/>
                  <.input field={@form[:gender]} type="select" label={gettext("Gender")} prompt={gettext("Select gender")} options={genders()} required />
                  <.input field={@form[:skill_level]} type="select" label={gettext("Skill level")} prompt={gettext("Select level")}  options={skill_levels()} required/>
                  <.input field={@form[:borough]} type="select" label={gettext("Borough")} prompt={gettext("Select borough")} options={boroughs()} required />
                </span>
              </div>
              <div class="cols-span-1 group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6">
                <span class="absolute inset-0 rounded-2xl bg-amber-50 transition group-hover:bg-amber-100 sm:group-hover:scale-105">
                </span>
                <span class="relative flex items-center gap-4 mb-7 text-lg text-yellow-600 sm:flex-row">
                  <.icon name="hero-star-solid" class="h-6 w-6  place-self-center" />
                  <%= gettext("Preferences") %>
                </span>
                <span class="relative flex-auto items-start space-y-4 sm:flex-col">
                  <.input field={@form[:game_style_preference]} type="select" label={gettext("Game style")} prompt={gettext("Select style")} options={play_styles()} required />
                  <.input field={@form[:game_format_preference]} type="select" label={gettext("Game format")} prompt={gettext("Select format")} options={game_formats()} required />
                  <.input field={@form[:game_time_preference]} type="datetime-local" label={gettext("Game time")} required/>
                  <.input field={@form[:game_time_reccurrence]} type="select" label={gettext("Game recurrence")} options={game_reccurrences()} required />
                </span>
              </div>
            </div>
          </div>
        </div>
        <:actions>
          <.button phx-disable-with="Finding games..." class="w-full bg-brand/80 hover:bg-brand/90">
            <%= gettext("Find games") %>
          </.button>
        </:actions>
      </.simple_form>
      <div class="stitched bottom-10 mt-10 grid grid-cols-2 text-sm leading-6 text-zinc-700 sm:grid-cols-2">
          <div class="place-self-start">
            <a
              href="https://twitter.com"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M5.403 14c5.283 0 8.172-4.617 8.172-8.62 0-.131 0-.262-.008-.391A6.033 6.033 0 0 0 15 3.419a5.503 5.503 0 0 1-1.65.477 3.018 3.018 0 0 0 1.263-1.676 5.579 5.579 0 0 1-1.824.736 2.832 2.832 0 0 0-1.63-.916 2.746 2.746 0 0 0-1.821.319A2.973 2.973 0 0 0 8.076 3.78a3.185 3.185 0 0 0-.182 1.938 7.826 7.826 0 0 1-3.279-.918 8.253 8.253 0 0 1-2.64-2.247 3.176 3.176 0 0 0-.315 2.208 3.037 3.037 0 0 0 1.203 1.836A2.739 2.739 0 0 1 1.56 6.22v.038c0 .7.23 1.377.65 1.919.42.54 1.004.912 1.654 1.05-.423.122-.866.14-1.297.052.184.602.541 1.129 1.022 1.506a2.78 2.78 0 0 0 1.662.598 5.656 5.656 0 0 1-2.007 1.074A5.475 5.475 0 0 1 1 12.64a7.827 7.827 0 0 0 4.403 1.358" />
              </svg>
              <%= gettext("Follow on Twitter") %>
            </a>
          </div>
          <div class="place-self-end">
            <a
              href="https://chat.whatsapp.com/JsDUo7lDYPzArWXtRCrbXI"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
              </svg>
              <%= gettext("Chat on Whatsapp") %>
            </a>
          </div>
      </div>
      <.modal id="how-it-works-modal">
        <%= gettext("Create an account and find people to play with. It's as simple as that.") %>
      </.modal>
      <.modal id="cities-modal">
        <%= gettext("Currently we are live in the city of Montreal. More cities to come!") %>
      </.modal>
      <.modal id="sports-modal">
        <%= gettext("At the moment we help you find games for Pickeball and Tennis. More sports to come!") %>
      </.modal>

      <.modal
        :if={@show_modal}
        id="onboarding_registration_modal"
        show
        on_cancel={JS.push("close_registration_modal")}
        >
        <.live_component
          id="registration_modal"
          profile={@form.params}
          module={SportMatchMakerWeb.OnboardingLive.ModalComponent}
          patch={~p"/"}
        />
      </.modal>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Profile.changeset(%Profile{}, %{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false, show_modal: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("open_registration_modal", %{"profile" => profile_params}, socket) do
    changeset = Profile.changeset(%Profile{}, profile_params)
    {:noreply, assign(socket, form: to_form(changeset, as: "profile"), check_errors: false, show_modal: true)}
  end

  def handle_event("close_registration_modal", params, socket) do
    changeset = Profile.changeset(%Profile{}, params)
    {:noreply, assign(socket, form: to_form(changeset, as: "profile"), check_errors: false, show_modal: false)}
  end

  def handle_event("validate", %{"profile" => profile_params}, socket) do
    changeset = Profile.changeset(%Profile{}, profile_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "profile")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  defp age_groups() do
    ["18-25", "26-35", "36-45", "46-55", "56-65", "66+"]
  end

  defp genders() do
    [:male, :female]
  end

  defp boroughs() do
    [
      "Ahuntsic-Cartierville",
      "Anjou",
      "Baie D’Urfé",
      "Beaconsfield",
      "Belœil",
      "Boucherville",
      "Brossard",
      "Candiac",
      "Carignan",
      "Côte-des-Neiges–Notre-Dame-de-Grâce",
      "Côte Saint-Luc",
      "Chambly",
      "Charlemagne",
      "Châteauguay",
      "Deux-Montagnes",
      "Delson",
      "Dollard-des-Ormeaux",
      "Dorval",
      "Hampstead",
      "Kirkland",
      "Lachine",
      "La Prairie",
      "LaSalle",
      "L\'Assomption",
      "L’Île-Bizard–Sainte-Geneviève",
      "L’Île-Dorval",
      "Lorraine",
      "Le Plateau-Mont-Royal",
      "Le Sud-Ouest",
      "Mascouche",
      "McMasterville",
      "Mercier–Hochelaga-Maisonneuve",
      "Mirabel",
      "Montréal-Est",
      "Montréal-Nord",
      "Montréal-Ouest",
      "Mont-Royal",
      "Mont-Saint-Hilaire",
      "Oka",
      "Otterburn Park",
      "Outremont",
      "Pierrefonds-Roxboro",
      "Pointe-Claire",
      "Pointe-Calumet",
      "Repentigny",
      "Rivière-des-Prairies–Pointe-aux-Trembles",
      "Rosemont–La Petite-Patrie",
      "Rosemère",
      "Sainte-Anne-de-Bellevue",
      "Sainte-Anne-des-Plaines",
      "Sainte-Catherine",
      "Sainte-Julie",
      "Sainte-Marthe-sur-le-Lac",
      "Sainte-Thérèse",
      "Saint-Basile-le-Grand",
      "Saint-Bruno-de-Montarville",
      "Saint-Constant",
      "Saint-Eustache",
      "Saint-Hubert",
      "Saint-Isidore",
      "Saint-Jean-sur-Richelieu",
      "Saint-Joseph-du-Lac",
      "Saint-Lambert",
      "Saint-Laurent",
      "Saint-Léonard",
      "Saint-Mathias",
      "Saint-Philippe",
      "Saint-Sulpice",
      "Senneville",
      "Terrebonne",
      "Verdun",
      "Varennes",
      "Vieux-Longueuil",
      "Ville-Marie",
      "Villeray–Saint-Michel–Parc-Extension",
      "Westmount"
    ]
  end

  defp game_formats() do
    [:single, :double, :all]
  end

  defp play_styles() do
    [:practice, :competition, :all]
  end

  defp skill_levels() do
    [:beginner, :intermediate, :advanced, :competitor]
  end

  defp game_reccurrences() do
    [:never, :daily, :weekly]
  end
end
