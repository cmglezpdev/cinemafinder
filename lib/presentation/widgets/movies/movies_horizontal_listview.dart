import 'package:cinemafinder/config/helpers/human_formants.dart';
import 'package:cinemafinder/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
  
  const MoviesHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          if(title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle),

          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);
              },
            )
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          SizedBox(
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 180,
                height: 250,
                loadingBuilder:(context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const SizedBox(
                      width: 180,
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator( strokeWidth: 2)
                      ),
                    );
                  }
                  return child;
                }
              )
            )
          ),

          const SizedBox(height: 5),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          // Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text(movie.voteAverage.toStringAsFixed(1), style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                const Spacer(),
                Text(HumanFormants.number(movie.popularity), style: textStyle.bodySmall),
              ],
            ),
          )
        ],
      ) 
    ); 
  }
}


class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;
  
  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: titleStyle),

          const Spacer(),

          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!) 
            )

        ],
      ),
    );
  }
}