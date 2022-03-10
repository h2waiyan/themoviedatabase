import 'package:moviedb/models/res_popular.dart';

import '../models/movie.dart';
import 'package:http/http.dart' as http;

class API {
  final String _apikey = "050c28541f900007285c3020069bfd62";
  final String _baseURL = "https://api.themoviedb.org/3";
  static const String imageURL = "https://image.tmdb.org/t/p/w200";
  var name = "batman";

  Future<List<Movie>> getList(String url, {String param = ""}) async {
    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apikey&$param"),
    );

    if (response.statusCode == 200) {
      var resp = ResPopular.fromRawJson(response.body);
      return resp.results;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Movie>> getPopular() async {
    return getList("/movie/popular");
  }

  Future<List<Movie>> getNowPlaying() async {
    return getList("/movie/now_playing");
  }

  Future<List<Movie>> getSearch(String name) async {
    return getList("/search/movie", param: "query=$name");
  }
}
