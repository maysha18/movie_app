import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/comingSoon.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/services/dio_methods.dart';
import 'package:movie_app/services/network_exceptions.dart';

final upcomingMoviesNotifier = NotifierProvider(() => UpcomingMoviesProvider());

class UpcomingMoviesProvider extends Notifier {
  Future<CominSoonModel> getComingSoon(String url) async {
    try {
      var response = await DioMethod.dioGet(
        url,
        // queryParams: {"api_key": "${ApiUrl.apiKey}"}
      );

      return CominSoonModel.fromJson(response);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  @override
  build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
