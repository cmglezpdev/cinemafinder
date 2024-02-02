

import 'package:cinemafinder/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:movieId',
          name: MovieScreen.name,
          builder: (context, state) => MovieScreen(
            movieId: state.pathParameters['movieId'] ?? 'no-id',
          )
        )
      ]
    ),
  ]
);