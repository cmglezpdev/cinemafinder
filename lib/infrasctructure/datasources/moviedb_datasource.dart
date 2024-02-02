


import 'package:cinemafinder/config/constants/environment.dart';
import 'package:cinemafinder/domain/datasources/movies_datasource.dart';
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/infrasctructure/mappers/movie_mapper.dart';
import 'package:cinemafinder/infrasctructure/models/moviedb/moviedb_details.dart';
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


  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviesDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = moviesDbResponse.results.map(
      (movieDb) => MovieMapper.fromMovieDB(movieDb)
    ).toList();

    return movies;
  }


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page
    });
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page
    });
    
    return _jsonToMovies(response.data);
  }

    @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page
    });
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if(response.statusCode != 200) {
      throw Exception('Movie with id $id not found');
    }

    final movieDb = MovieDbDetails.fromJson(response.data);
    return MovieMapper.fromMovieDBDetails(movieDb);
  }
}