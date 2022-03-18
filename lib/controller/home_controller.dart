import 'package:get/get.dart';
import 'package:moviedb/models/movie.dart';
import 'package:moviedb/network/api.dart';

class HomeController extends GetxController {
  RxList<Movie> popularMovies = <Movie>[].obs;
  RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  RxList<Movie> searchedMoives = <Movie>[].obs;

  loadPopular() {
    API().getPopular().then((value) {
      popularMovies.value = value;
    });
  }

  loadNowPlaying() {
    API().getNowPlaying().then((value) {
      nowPlayingMovies.value = value;
    });
  }

  loadSearch(String searchText) {
    API().getSearch(searchText).then((value) {
      searchedMoives.value = value;
    });
  }
}
