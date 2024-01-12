import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/screens/actors/actors_view.dart';
import 'package:movie_app/screens/similar_movies/similar_movies_view.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDeatilPage extends ConsumerWidget {
  const MovieDeatilPage({super.key, required this.movieData});

  final Results movieData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final String titlePath = movieData.backdropPath;
    final String movieName = movieData.title;
    final String movieOverview = movieData.overview;
    final int movieId = movieData.id;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height / 3),
        child: SafeArea(
          child: AppBar(
            flexibleSpace: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: "http://image.tmdb.org/t/p/w780/$titlePath",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text(
              movieName,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              movieOverview,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.check,
                  size: 25.0,
                ),
                Icon(
                  FontAwesomeIcons.shareAlt,
                  size: 25.0,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('My List'),
                Text('Share'),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Cast',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Actors(movieId),
            const SizedBox(height: 10.0),
            const Text(
              'Similar movies',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SimilarMoviesPage(movieId),
          ],
        ),
      ),
    );
  }
}
