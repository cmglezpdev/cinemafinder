
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:cinemafinder/presentation/delegates/searh_movie_delegate.dart';
import 'package:cinemafinder/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary, size: 30),
              const SizedBox(width: 5),
              Text( 'Cinemafinder', style: titleStyle),
              const Spacer(),

              IconButton(
                onPressed: () {
                  final searchMovie = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      initialMovies: searchMovie,
                      searchMovieCallback: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
                    )
                  ).then((movie) {
                    if(movie == null) return;
                    context.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}