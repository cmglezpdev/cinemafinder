


import 'package:cinemafinder/domain/datasources/actors_datasource.dart';
import 'package:cinemafinder/domain/entities/actor.dart';
import 'package:cinemafinder/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}