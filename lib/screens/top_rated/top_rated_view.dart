import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/top_rated/top_rated_provider.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/widgets/horizontal_cards.dart';

class TopRated extends ConsumerStatefulWidget {
  const TopRated({super.key});

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends ConsumerState<TopRated> {
  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(topRatedProviderNotifier.notifier);
    return FutureBuilder(
      future: controllerRef.getTopRated(ApiUrl.topRated),
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
