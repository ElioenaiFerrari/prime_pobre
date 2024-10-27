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
  title: "The Matrix",
  description:
    "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
  video_url: "https://videos.pexels.com/video-files/8953675/8953675-uhd_1440_2560_30fps.mp4",
  images: [
    "https://images.pexels.com/photos/1089438/pexels-photo-1089438.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
  ]
})

{:ok, serie} =
  Series.create_serie(%{
    title: "Breaking Bad",
    description:
      "A high school chemistry teacher turned methamphetamine manufacturer partners with a former student to secure his family's future.",
    images: [
      "https://images.pexels.com/photos/1089438/pexels-photo-1089438.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    ]
  })

{:ok, season} =
  SerieSeasons.create_serie_season(serie, %{
    number: 1
  })

SerieSeasonEpisodes.create_serie_season_episode(season, %{
  title: "Pilot",
  description:
    "Diagnosed with terminal lung cancer, a high school chemistry teacher resorts to cooking and selling methamphetamine to provide for his family.",
  video_url: "https://videos.pexels.com/video-files/8953675/8953675-uhd_1440_2560_30fps.mp4",
  images: [
    "https://images.pexels.com/photos/1089438/pexels-photo-1089438.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
  ]
})
