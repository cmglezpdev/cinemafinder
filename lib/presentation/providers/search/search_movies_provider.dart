import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final searchQueryProvider = StateProvider<String>((ref) => '');


final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(moviesRepositoryProvider);
  
  return SearchedMoviesNotifier(
    searchMovieCallback: movieRepository.searchMovies,
  );
});



typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final Map<String, List<Movie>> _searchedMovies = {};
  final SearchMovieCallback searchMovieCallback;

  SearchedMoviesNotifier({
    required this.searchMovieCallback
  }): super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    if(_searchedMovies.containsKey(query)) {
      return _searchedMovies[query]!;
    }

    final movies = await searchMovieCallback(query);
    _searchedMovies[query] = movies;
    return movies;
  }
}