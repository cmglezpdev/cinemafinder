import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');


final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(moviesRepositoryProvider);
  
  return SearchedMoviesNotifier(
    searchMovieCallback: movieRepository.searchMovies,
    ref: ref
  );
});



typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMovieCallback searchMovieCallback;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchMovieCallback,
    required this.ref
  }): super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final movies = await searchMovieCallback(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}