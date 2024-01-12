import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/similarMoviesModel.dart';
import 'package:movie_app/models/topRatedModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/services/dio_methods.dart';
import 'package:movie_app/services/network_exceptions.dart';

final similarMoviesProviderrNotifier =
    NotifierProvider(() => SimilarMoviesProvider());

class SimilarMoviesProvider extends Notifier {
  Future<SimilarMoviesModel> similarMovies(String url, int movieId) async {
    try {
      var response = await DioMethod.dioGet(
        "$url/$movieId/similar",
      );
      return SimilarMoviesModel.fromJson(response);
    } catch (exception) {
      final errorMessage = NetworkExceptions.getErrorMessage(exception);
      return Future.error(errorMessage);
    }
  }

  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
