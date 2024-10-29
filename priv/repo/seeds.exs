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
  media: "movies/radio_pesadelo.mkv",
  source: "file",
  thumbnail_url:
    "https://www.justwatch.com/images/backdrop/319854719/s640/radio-pesadelo/radio-pesadelo",
  mime_type: "video/mp4",
  genre: "Horror",
  duration: 90
})

{:ok, serie} =
  Series.create_serie(%{
    title: "Peaky Blinders",
    description:
      "A gangster family epic set in 1919 Birmingham, England and centered on a gang who sew razor blades in the peaks of their caps, and their fierce boss Tommy Shelby, who means to move up in the world.",
    thumbnail_url:
      "https://gizmodo.uol.com.br/wp-content/blogs.dir/8/files/2023/07/peaky-blinders.jpg",
    genre: "Drama"
  })

{:ok, season} =
  SerieSeasons.create_serie_season(serie, %{
    number: 1
  })

SerieSeasonEpisodes.create_serie_season_episode(season, %{
  title: "The Fellowship of the Ring",
  description:
    "A young hobbit, Frodo, who has found the One Ring that belongs to the Dark Lord Sauron, begins his journey with eight companions to Mount Doom, the only place where it can be destroyed.",
  media: "https://videos.pexels.com/video-files/28828145/12487871_1440_2560_60fps.mp4",
  source: "remote",
  thumbnail_url:
    "https://gizmodo.uol.com.br/wp-content/blogs.dir/8/files/2023/07/peaky-blinders.jpg",
  mime_type: "video/mp2t",
  duration: 178,
  number: 1
})
