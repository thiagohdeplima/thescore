defmodule TheScoreWeb.PlayerView do
  use TheScoreWeb, :view
  alias TheScoreWeb.PlayerView

  def render("index.json", %{page: page}) do
    %{
      page_size: page.page_size,
      page_number: page.page_number,
      total_pages: page.total_pages,
      total_entries: page.total_entries,
 
      entries: render_many(page.entries, PlayerView, "player.json")
    }
  end

  def render("show.json", %{player: player}) do
    render_one(player, PlayerView, "player.json")
  end

  def render("player.json", %{player: player}) do
    %{
      id: player.id,

      name: player.name,
      team: player.team,
      pos: player.pos,
        
      attg: player.attg,
      att: player.att,
      yds: player.yds,
      avg: player.avg,
      ydsg: player.ydsg,
      td: player.td,
      lng: player.lng,
      r1st: player.r1st,
      r1stp: player.r1stp,
        
      r20plus: player.r20plus,
      r40plus: player.r40plus,
        
      fum: player.fum
    }
  end
end
