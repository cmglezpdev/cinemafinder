import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const String name = 'movie-screen'; 
  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Id: $movieId'),
      ),
    );
  }
}