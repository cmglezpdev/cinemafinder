import 'package:cinemafinder/domain/repositories/actors_repository.dart';
import 'package:cinemafinder/infrasctructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemafinder/infrasctructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider<ActorsRepository>(
  (ref) => ActorsRepositoryImpl(datasource: ActorMovieDbDatasource())
);