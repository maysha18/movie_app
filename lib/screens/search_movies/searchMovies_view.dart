import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/search_movies/searchMovies_provider.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/widgets/horizontal_cards.dart';

class SearchMoviesPage extends ConsumerStatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  _SearchMoviesPageState createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends ConsumerState<SearchMoviesPage> {
  final searchController = TextEditingController();
  String movieName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // this widget shows not found image
  Widget _notFoundWidget() {
    return Center(
      child: Image.asset('assets/images/not_found.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controllerRef = ref.watch(searchMoviesProviderrNotifier.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Enter Movie name'),
                  controller: searchController,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.pink[200])),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (searchController.text != '') {
                    setState(() {
                      movieName = searchController.text;
                      controllerRef.searchMovies(
                          ApiUrl.searchMovies, movieName);
                    });
                  } else {
                    setState(() {
                      movieName = '';
                    });
                  }
                },
                child: Text('Search'),
              ),
            ),
            movieName == ''
                ? Expanded(
                    child: _notFoundWidget(),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: controllerRef.searchMovies(
                          ApiUrl.searchMovies, movieName),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return _notFoundWidget();
                        } else {
                          final List movieData = snapshot.data.results;
                          movieData
                              .removeWhere((item) => item.posterPath == null);
                          if (movieData == []) {
                            return _notFoundWidget();
                          } else {
                            return HorizontalCards(movieData);
                          }
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
