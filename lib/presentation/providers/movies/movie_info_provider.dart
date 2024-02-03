import 'package:cinemafinder/domain/entities/movie_details.dart';
import 'package:cinemafinder/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieDetailsProvider = StateNotifierProvider<MovieMapNotifier, Map<String, MovieDetails>>((ref) {
  final movieRepository = ref.watch(moviesRepositoryProvider);
  return MovieMapNotifier(
    getMovie: movieRepository.getMovieDetails
  );
});



typedef GetMovieCallback = Future<MovieDetails> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, MovieDetails>> {
  final GetMovieCallback getMovie;
  
  MovieMapNotifier({
    required this.getMovie,
  }): super({});

  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;
  
    final movie = await getMovie(movieId);
    state = {
      ...state,
      movieId: movie
    };
  }

}