require Logger

insert_players = fn ->
  "rushing.json"
  |> File.read!()
  |> Jason.decode!()
  |> Enum.map(fn player ->
    {:ok, _} =
      player
      |> Map.put("name", player["Player"])
      |> Map.put("team", player["Team"])
      |> Map.put("pos", player["Pos"])
      |> Map.put("attg", player["Att"])
      |> Map.put("att", player["Att/G"])
      |> Map.put("yds", player["Yds"])
      |> Map.put("avg", player["Avg"])
      |> Map.put("ydsg", player["Yds/G"])
      |> Map.put("td", player["TD"])
      |> Map.put("lng", player["Lng"])
      |> Map.put("r1st", player["1st"])
      |> Map.put("r1stp", player["1st%"])
      |> Map.put("r20plus", player["20+"])
      |> Map.put("r40plus", player["40+"])
      |> Map.put("fum", player["FUM"])
      |> Enum.map(fn
        {"lng", value} when is_number(value) ->
          {"lng", Integer.to_string(value)}

        {key, value} when is_binary(value) ->
          {key, String.replace(value, ",", ".")}

        other ->
          other
      end)
      |> Map.new()
      |> TheScore.Statistics.create_player()
  end)
end

if TheScore.Statistics.list_players() == [] do
  insert_players.()
else
  Logger.info("Players already inserted")
end
