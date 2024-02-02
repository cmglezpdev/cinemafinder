import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovieCallback;
  final StreamController debouncedMovies = StreamController<List<Movie>>.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovieCallback
  });

  void _clearStreams() {
    debouncedMovies.close();
  }

  Future<void> _onQueryChanged(String query) async {
    if(_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if(query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }
    
      final movies = await searchMovieCallback(query);
      debouncedMovies.add(movies);
    });
  }


  @override
  // TODO: show text based in new films
  String? get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear)
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
      
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieSearchItem(
              movie: movies[index],
              onMovieSelected: (conext, movie) {
                _clearStreams();
                context.push('/movie/${movie.id}');
              }
            );
          }
        );
      },
    );
  }

}



class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie) onMovieSelected;

  const _MovieSearchItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                )
              ),
            ),
      
            const SizedBox(width: 10),
      
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  Text(
                    movie.overview, 
                    style: textStyles.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: textStyles.bodySmall!.copyWith(
                          color: Colors.yellow.shade800
                        )
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}