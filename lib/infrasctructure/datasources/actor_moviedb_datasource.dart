


import 'package:cinemafinder/config/constants/environment.dart';
import 'package:cinemafinder/domain/datasources/actors_datasource.dart';
import 'package:cinemafinder/domain/entities/actor.dart';
import 'package:cinemafinder/infrasctructure/mappers/actor_mapper.dart';
import 'package:cinemafinder/infrasctructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-ES'
    }
  ));

  List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final creditsResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = creditsResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }



  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    return _jsonToActors(response.data);
  }
}