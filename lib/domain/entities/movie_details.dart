

class MovieDetails {
  final int id;
  final bool adult;
  final String posterPath;
  final String backdropPath;
  final List<String> genres;
  final String title;
  final String originalTitle;
  final String tagline;
  final String overview;
  final int runtime;
  final DateTime? releaseDate;
  final String originalLanguage;
  final List<String> spokenLanguages;
  final int budget;
  final int revenue;
  final String status;
  final double voteAverage;
  final int voteCount;
  final double popularity;

  MovieDetails(
      {required this.id,
      required this.adult,
      required this.posterPath,
      required this.backdropPath,
      required this.genres,
      required this.title,
      required this.originalTitle,
      required this.tagline,
      required this.overview,
      required this.runtime,
      required this.releaseDate,
      required this.originalLanguage,
      required this.spokenLanguages,
      required this.budget,
      required this.revenue,
      required this.status,
      required this.voteAverage,
      required this.voteCount,
      required this.popularity});
}
