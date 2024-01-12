import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/trendMovies/trendMovies_provider.dart';
import 'package:movie_app/services/apiUrl.dart';

import 'package:movie_app/widgets/horizontal_cards.dart';

class TrendingMovies extends ConsumerStatefulWidget {
  const TrendingMovies({super.key});

  @override
  _TrendingMoviesState createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends ConsumerState<TrendingMovies> {
  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(trendMoviesProviderNotifier.notifier);
    return FutureBuilder(
      future: controllerRef.getTrendingMovies(ApiUrl.trendingMovie),
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
