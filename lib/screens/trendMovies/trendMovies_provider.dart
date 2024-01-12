import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/services/dio_methods.dart';
import 'package:movie_app/services/network_exceptions.dart';

final trendMoviesProviderNotifier =
    NotifierProvider(() => TrendMoviesProvider());

class TrendMoviesProvider extends Notifier {
  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<TrendingMoviesModel> getTrendingMovies(String url) async {
    try {
      var response = await DioMethod.dioGet(
        url,
      );

      return TrendingMoviesModel.fromJson(response);
    } catch (exception) {
      final errorMessage = NetworkExceptions.getErrorMessage(exception);
      return Future.error(errorMessage);
    }
  }
}
