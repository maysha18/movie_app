import 'package:flutter/material.dart';
import 'package:movie_app/screens/trendMovies/trendMovies_view.dart';
import 'package:movie_app/screens/upcoming_movies/upcoming_movies_view.dart';

import '../top_rated/top_rated_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Trending Movies',
              style: TextStyle(fontSize: 18.0),
            ),
            TrendingMovies(),
            Text(
              'Top Rated Movies',
              style: TextStyle(fontSize: 18.0),
            ),
            TopRated(),
            Text(
              'Upcoming Movies',
              style: TextStyle(fontSize: 18.0),
            ),
            UpcomingMovies(),
          ],
        ),
      ),
    );
  }
}
