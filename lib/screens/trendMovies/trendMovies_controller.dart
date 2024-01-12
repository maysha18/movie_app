import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/nowPlayingModel.dart';
import 'package:movie_app/models/trendingModel.dart';
import 'package:movie_app/screens/homePage/homePage_provider.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/services/dio_methods.dart';

final trendMoviesControllerNotifier =
    NotifierProvider(() => TrendMoviesController());

class TrendMoviesController extends Notifier {
  @override
  build() {}
}
