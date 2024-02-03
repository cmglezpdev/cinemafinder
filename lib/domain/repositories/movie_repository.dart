
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/domain/entities/movie_details.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getUpcoming({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<List<Movie>> searchMovies(String query, { int page = 1 });


  Future<MovieDetails> getMovieDetails(String id);
}