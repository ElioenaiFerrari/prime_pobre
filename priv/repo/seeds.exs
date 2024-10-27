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
alias PrimePobre.{Movies, Series, SerieSeasons, SerieSeasonEpisodes}

Movies.create_movie(%{
  title: "Radio Pesadelo",
  description:
    "A radio station in the middle of nowhere becomes the center of a zombie invasion.",
  video_url: "file://radio_pesadelo.mkv",
  images:
    "https://www.justwatch.com/images/backdrop/319854719/s640/radio-pesadelo/radio-pesadelo",
  mime_type: "video/mp4",
  genre: "Horror",
  duration: 90
})

{:ok, serie} =
  Series.create_serie(%{
    title: "O Senhor dos Anéis",
    description:
      "A young hobbit, Frodo, who has found the One Ring that belongs to the Dark Lord Sauron, begins his journey with eight companions to Mount Doom, the only place where it can be destroyed.",
    images: ["https://image.tmdb.org/t/p/w342/9mZhIun3HhIUi2jneZzm5D20ZTj.jpg"],
    genre: "Fantasia"
  })

{:ok, season} =
  SerieSeasons.create_season(serie, %{
    number: 2
  })

SerieSeasonEpisodes.create_episode(season, %{
  title: "The Fellowship of the Ring",
  description:
    "A young hobbit, Frodo, who has found the One Ring that belongs to the Dark Lord Sauron, begins his journey with eight companions to Mount Doom, the only place where it can be destroyed.",
  video_url: "file://lord_of_the_ring",
  images: ["https://image.tmdb.org/t/p/w342/9mZhIun3HhIUi2jneZzm5D20ZTj.jpg"],
  mime_type: "video/mp4",
  duration: 178,
  number: 1
})
