import 'package:get/get.dart';
import 'package:moviedb/models/cast.dart';
import 'package:moviedb/network/api.dart';

import '../models/movie.dart';

class DetailsController extends GetxController {
  RxList<Cast> casts = <Cast>[].obs;
  RxList<Movie> recommend = <Movie>[].obs;

  loadCast(int movieId) {
    API().getCast(movieId).then((value) {
      casts.value = value;
    });
  }

  loadRecommend(int movieId) {
    API().getRecommendedMovie(movieId).then((value) {
      recommend.value = value;
    });
  }
}
