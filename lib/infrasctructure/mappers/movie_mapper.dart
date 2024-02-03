

import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/infrasctructure/models/moviedb/movie_moviedb.dart';
import 'package:cinemafinder/infrasctructure/models/moviedb/moviedb_details.dart';

class MovieMapper {

  static Movie fromMovieDB(MovieFromMovieDB movieDB) => Movie(
    adult: movieDB.adult, 
    backdropPath: movieDB.backdropPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    id: movieDB.id, 
    originalLanguage: movieDB.originalLanguage, 
    originalTitle: movieDB.originalTitle, 
    overview: movieDB.overview, 
    popularity: movieDB.popularity, 
    posterPath: movieDB.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    releaseDate: movieDB.releaseDate, 
    title: movieDB.title, 
    video: movieDB.video, 
    voteAverage: movieDB.voteAverage, 
    voteCount: movieDB.voteCount
  );

  static Movie fromMovieDBDetails(MovieDbDetails movieDB) => Movie(
        adult: movieDB.adult, 
    backdropPath: movieDB.backdropPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    id: movieDB.id, 
    originalLanguage: movieDB.originalLanguage, 
    originalTitle: movieDB.originalTitle, 
    overview: movieDB.overview, 
    popularity: movieDB.popularity, 
    posterPath: movieDB.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    releaseDate: movieDB.releaseDate, 
    title: movieDB.title, 
    video: movieDB.video, 
    voteAverage: movieDB.voteAverage, 
    voteCount: movieDB.voteCount
  );
}