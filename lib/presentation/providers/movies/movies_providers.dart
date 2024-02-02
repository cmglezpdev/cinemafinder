import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getPopular;
  
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getUpcoming;
  
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getTopRated;
  
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
});




typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;
    currentPage ++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    
    await Future.delayed(const Duration(milliseconds: 300)); // time to render the new items
    isLoading = false;
  }
}