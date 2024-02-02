


import 'package:cinemafinder/domain/datasources/movies_datasource.dart';
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/domain/repositories/movie_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl({required this.datasource});
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) {
    return datasource.searchMovies(query, page: page);
  }
}