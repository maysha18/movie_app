import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/topRatedModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/services/dio_methods.dart';
import 'package:movie_app/services/network_exceptions.dart';

final topRatedProviderNotifier = NotifierProvider(() => TopRatedProvider());

class TopRatedProvider extends Notifier {
  Future<TopRatedModel> getTopRated(String url) async {
    try {
      var response = await DioMethod.dioGet(
        url,
      );
      return TopRatedModel.fromJson(response);
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
