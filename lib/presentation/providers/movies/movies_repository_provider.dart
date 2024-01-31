import 'package:cinemafinder/domain/repositories/movie_repository.dart';
import 'package:cinemafinder/infrasctructure/datasources/moviedb_datasource.dart';
import 'package:cinemafinder/infrasctructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>(
  (ref) => MoviesRepositoryImpl(datasource: MoviesDbDatasource())
);