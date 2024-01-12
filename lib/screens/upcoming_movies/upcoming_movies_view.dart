import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/upcoming_movies/upcoming_movies_provider.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/widgets/horizontal_cards.dart';

class UpcomingMovies extends ConsumerStatefulWidget {
  const UpcomingMovies({super.key});

  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends ConsumerState<UpcomingMovies> {
  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(upcomingMoviesNotifier.notifier);
    return FutureBuilder(
      future: controllerRef.getComingSoon(ApiUrl.comingSoon),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          return HorizontalCards(snapshot.data.results);
        }
      },
    );
  }
}
