import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/similar_movies/similar_movies_provider.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/widgets/horizontal_cards.dart';

class SimilarMoviesPage extends ConsumerStatefulWidget {
  const SimilarMoviesPage(this.movieId, {super.key});
  final int movieId;

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends ConsumerState<SimilarMoviesPage> {
  int movieId = 0;
  @override
  void initState() {
    super.initState();
    movieId = widget.movieId;
  }

  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(similarMoviesProviderrNotifier.notifier);

    return FutureBuilder(
      future: controllerRef.similarMovies(
        ApiUrl.baseUrl,
        movieId,
      ),
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
