import 'package:cinemafinder/presentation/providers/movies/movies_providers.dart';
import 'package:cinemafinder/presentation/providers/providers.dart';
import 'package:cinemafinder/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}


class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    if (moviesSlideshow.isEmpty) {
      return const CircularProgressIndicator();
    }

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [                  
                  MoviesSlideshow(movies: moviesSlideshow),

                  MoviesHorizontalListview(
                    title: 'Now Playing',
                    subtitle: 'See all',
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                    movies: nowPlayingMovies
                  ),

                  MoviesHorizontalListview(
                    title: 'Popular',
                    subtitle: 'See all',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                    movies: popularMovies
                  ),

                  MoviesHorizontalListview(
                    title: 'Upcoming',
                    subtitle: 'See all',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                    movies: upcomingMovies
                  ),

                  
                  const SizedBox(height: 10)
                ],
              );
            }, 
            childCount: 1
          ),
        )
      ]
    );
  }
}
