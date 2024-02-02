
import 'package:cinemafinder/presentation/delegates/searh_movie_delegate.dart';
import 'package:cinemafinder/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  final moviesRepository = ref.read(moviesRepositoryProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      searchMovieCallback: (query) {
                        ref.read(searchQueryProvider.notifier).update((state) => query);
                        return moviesRepository.searchMovies(query);
                      }
                    )
                  );
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