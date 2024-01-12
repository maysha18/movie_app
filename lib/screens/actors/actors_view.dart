import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/actors/actors_provider.dart';
import 'package:movie_app/services/apiUrl.dart';

class Actors extends ConsumerStatefulWidget {
  final int movieId;
  const Actors(this.movieId, {super.key});
  @override
  _ActorsState createState() => _ActorsState();
}

class _ActorsState extends ConsumerState<Actors> {
  int movieId = 0;

  @override
  void initState() {
    super.initState();
    movieId = widget.movieId;
  }

  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(actorsPageProviderNotifier.notifier);

    return FutureBuilder(
      future: controllerRef.fetchCasts(ApiUrl.baseUrl, movieId),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          final List castData = snapshot.data.cast;
          castData.removeWhere((item) => item.profilePath == null);
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castData.length,
              itemBuilder: (context, index) {
                final String actorImage = castData[index].profilePath;
                final String actorName = castData[index].name;
                return Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                                  'http://image.tmdb.org/t/p/w780/$actorImage'),
                        ),
                        Text(
                          actorName,
                          style: TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
