import 'package:animate_do/animate_do.dart';
import 'package:cinemafinder/config/helpers/human_formants.dart';
import 'package:cinemafinder/domain/entities/movie_details.dart';
import 'package:cinemafinder/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen'; 
  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final MovieDetails? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if(movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2)
        ),
      );
    }


    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return  _MovieDetails(movie: movie);
            }, childCount: 1),
          )
        ],
      )
    );
  }
}


class _MovieDetails extends StatelessWidget {
  final MovieDetails movie;
  
  const _MovieDetails({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        // Principal Info
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    // Text(movie.tagline, style: textStyles.titleSmall),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),

        // Details
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ShowDetail(
                    title: 'Status', 
                    data: movie.status
                  ),
                  const SizedBox(height: 10),
                  ShowDetail(
                    title: 'Release Date', 
                    data: movie.releaseDate != null
                      ? HumanFormants.date(movie.releaseDate!)
                      : '-'
                  ),
                ],
              ),
          
              const SizedBox(width: 20),
          
              Column(
                children: [
                  ShowDetail(
                    title: 'Duration', 
                    data: HumanFormants.time(movie.runtime)
                  ),
                  const SizedBox(height: 10),
                  ShowDetail(
                    title: 'Languages', 
                    data: movie.spokenLanguages.join(', ')
                  ),
                ],
              ),
          
              const SizedBox(width: 20),
          
              Column(
                children: [
                  ShowDetail(
                    title: 'Budget', 
                    data: '\$${HumanFormants.number(movie.budget.toDouble())}'
                  ),
                  const SizedBox(height: 10),
                  ShowDetail(
                    title: 'Revenue', 
                    data: '\$${HumanFormants.number(movie.revenue.toDouble())}'
                  ),
                ],
              ),
            ],
          ),
        ),

        // Genres
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genres.map((genre) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ))
            ],
          ),
        ),


        // Actors
        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 50)
      ],
    );
  }
}


class ShowDetail extends StatelessWidget {
  final String title;
  final String data;

  const ShowDetail({
    super.key, 
    required this.title, 
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    
    return Column(
      children: [
        Text(title, style: textStyles.titleMedium),
        Text(data)
      ],
    );
  }
}



class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if(actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: ((context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      width: 135,
                      height: 180,
                      fit: BoxFit.cover
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '', 
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                ),

              ],
            ),
          );
        }),
      ),
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {
  final MovieDetails movie;
  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const SizedBox();
                  }
                  return FadeIn(child: child);
                },
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                )
              )
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.3],
                    colors: <Color>[
                      Colors.black45,
                      Colors.transparent,
                    ],
                  ),
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
