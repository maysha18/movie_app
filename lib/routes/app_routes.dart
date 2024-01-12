import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/global.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/routes/app_pages.dart';
import 'package:movie_app/screens/homePage/homePage_view.dart';
import 'package:movie_app/screens/movie_detail/movie_detail_view.dart';
import 'package:movie_app/screens/search_movies/searchMovies_view.dart';
import 'package:movie_app/screens/similar_movies/similar_movies_view.dart';
import 'package:movie_app/screens/top_rated/top_rated_view.dart';
import 'package:movie_app/screens/trendMovies/trendMovies_view.dart';
import 'package:movie_app/screens/upcoming_movies/upcoming_movies_view.dart';
import 'package:movie_app/models/nowPlayingModel.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    /// Forwards diagnostic messages to the dart:developer log() API.
    ///
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,

    /// Initial Routing Location
    initialLocation: Paths.INITIAL,
    routes: [
      GoRoute(
        name: Routes.INITIAL,
        path: Paths.INITIAL,
        builder: (context, state) {
          return MyInitialApp();
        },
      ),
      GoRoute(
        name: Routes.HOME,
        path: Paths.HOME,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: Routes.SIMILAR_MOVIES,
        path: Paths.SIMILAR_MOVIES,
        builder: (context, state) {
          return SimilarMoviesPage(state.extra as int);
        },
      ),
      GoRoute(
        name: Routes.UPCOMING_MOVIES,
        path: Paths.UPCOMING_MOVIES,
        builder: (context, state) {
          return const UpcomingMovies();
        },
      ),
      GoRoute(
        name: Routes.TREND_MOVIES,
        path: Paths.TREND_MOVIES,
        builder: (context, state) => const TrendingMovies(),
      ),
      GoRoute(
        name: Routes.TOP_RATED,
        path: Paths.TOP_RATED,
        builder: (context, state) => const TopRated(),
      ),
      GoRoute(
        name: Routes.SEARCH_MOVIES,
        path: Paths.SEARCH_MOVIES,
        builder: (context, state) => const SearchMoviesPage(),
      ),
      GoRoute(
        name: Routes.MOVIES_DETAIL,
        path: Paths.MOVIES_DETAIL,
        builder: (context, state) =>
            MovieDeatilPage(movieData: state.extra as Results),
      ),
    ],
  ),
);
