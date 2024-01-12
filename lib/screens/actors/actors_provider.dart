import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/castModel.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/services/dio_methods.dart';
import 'package:movie_app/services/network_exceptions.dart';

final actorsPageProviderNotifier = NotifierProvider(() => ActorsPageProvider());

class ActorsPageProvider extends Notifier {
  Future<CastModel> fetchCasts(String url, int movieId) async {
    try {
      var response = await DioMethod.dioGet("$url/$movieId/casts");
      return CastModel.fromJson(response);
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
