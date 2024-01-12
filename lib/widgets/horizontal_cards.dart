import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_detail/movie_detail_view.dart';

class HorizontalCards extends StatelessWidget {
  final List movieData;
  const HorizontalCards(this.movieData, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final String posterPath = movieData[index].posterPath;
          return Container(
            // width: MediaQuery.of(context).size.width * 0.6,
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return MovieDeatilPage(
                          movieData: movieData[index],
                        );
                      },
                    ),
                  );
                },
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: 'http://image.tmdb.org/t/p/w780/$posterPath'),
              ),
            ),
          );
        },
      ),
    );
  }
}
