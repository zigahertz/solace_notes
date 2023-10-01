defmodule SolaceWeb.NoteLive.Index do
  use SolaceWeb, :live_view

  alias Solace.Notes
  alias Solace.Notes.Note

  @impl true
  def mount(_params, _session, socket) do

    {:ok,
    socket
    |> assign(form: to_form(%{"search" => nil}))
    |> stream(:notes, Notes.list_notes())}
    # assigns(socket)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Note")
    |> assign(:note, Notes.get_note!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Note")
    |> assign(:note, %Note{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notes")
    |> assign(:note, nil)
  end

  @impl true
  def handle_info({SolaceWeb.NoteLive.FormComponent, {:saved, note}}, socket) do
    {:noreply, stream_insert(socket, :notes, note)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    note = Notes.get_note!(id)
    {:ok, _} = Notes.delete_note(note)

    {:noreply, stream_delete(socket, :notes, note)}
  end

  def handle_event("instant-search", %{"query" => ""}, socket) do
    {:noreply, stream(socket, :notes, Notes.list_notes(), reset: true)}
  end

  def handle_event("instant-search", %{"query" => query}, socket) do
    {:noreply, stream(socket, :notes, Notes.list_notes(query), reset: true)}
  end

  # defp assigns(socket, opts \\ []) do
  #   socket
  #   |> assign_new(:query, fn -> nil end)
  #   |> stream(:notes, Notes.list_notes())
  # end
end
