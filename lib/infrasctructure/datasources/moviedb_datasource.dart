


import 'package:cinemafinder/config/constants/environment.dart';
import 'package:cinemafinder/domain/datasources/movies_datasource.dart';
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/infrasctructure/mappers/movie_mapper.dart';
import 'package:cinemafinder/infrasctructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviesDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-ES'
    }
  ));


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final moviesDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = moviesDbResponse.results.map(
      (movieDb) => MovieMapper.fromMovieDB(movieDb)
    ).toList();

    return movies;
  }

}