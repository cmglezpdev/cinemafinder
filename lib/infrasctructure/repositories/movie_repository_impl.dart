


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

}