# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PrimePobre.Repo.insert!(%PrimePobre.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias PrimePobre.{Movies}

File.stream!("priv/repo/movies.csv")
|> CSV.decode!(
  escape_max_lines: 1000,
  field_transform: &String.trim/1
)
|> Enum.with_index()
|> Enum.each(fn {row, index} ->
  if index != 0 do
    Movies.create_movie(%{
      title: Enum.at(row, 0),
      description: Enum.at(row, 1),
      video_url: Enum.at(row, 2),
      images: Enum.at(row, 3) |> String.split("; "),
      mime_type: Enum.at(row, 4),
      genre: Enum.at(row, 5),
      duration: Enum.at(row, 6)
    })
  end
end)
