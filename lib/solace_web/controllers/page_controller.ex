defmodule SolaceWeb.PageController do
  use SolaceWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,

    redirect(conn, to: ~p"/notes")
    # so skip the default app layout.
    # render(conn, :home, layout: false)
  end
end
