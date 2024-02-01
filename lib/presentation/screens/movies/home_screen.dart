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
  }


  @override
  Widget build(BuildContext context) {
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    if(moviesSlideshow.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Column(
      children: [
        const CustomAppbar(),

        MoviesSlideshow(movies: moviesSlideshow.sublist(0, 6)),
        
        MoviesHorizontalListview(
          title: 'Cinema',
          subtitle: 'Monday 26',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          movies: moviesSlideshow
        )
      ],
    );
  }
}