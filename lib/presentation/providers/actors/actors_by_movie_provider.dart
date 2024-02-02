import 'package:cinemafinder/domain/entities/actor.dart';
import 'package:cinemafinder/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsByMovieProvider = StateNotifierProvider<ActorByMoviesNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorByMoviesNotifier(
    getActors: actorsRepository.getActorsByMovie
  );
});



typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorByMoviesNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;
  
  ActorByMoviesNotifier({
    required this.getActors,
  }): super({});

  Future<void> loadActors(String movieId) async {
    if(state[movieId] != null) return;
  
    final List<Actor> actors = await getActors(movieId);
    state = {
      ...state,
      movieId: actors
    };
  }

}