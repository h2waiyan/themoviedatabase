import 'package:flutter/material.dart';
import 'package:moviedb/models/movie.dart';
import 'package:moviedb/network/api.dart';
import 'package:moviedb/pages/search_page.dart';

import '../components/movie_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? popularMovie;
  List<Movie>? nowPlayingMovie;
  bool popularLoading = true;
  bool nowPlayingLoading = true;

  loadMovie() {
    API().getNowPlaying().then((value) {
      setState(() {
        nowPlayingMovie = value;
        nowPlayingLoading = false;
      });
    });

    API().getPopular().then((value) {
      setState(() {
        popularMovie = value;
        popularLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Database"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SearchPage())));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [
            nowPlayingLoading == true
                ? const CircularProgressIndicator(color: Colors.red,)
                : MovieList(
                    movieList: nowPlayingMovie!,
                    title: "On Theatre",
                    forHeroTag: "now"
                  ),
            popularLoading == true
                ? const CircularProgressIndicator(color: Colors.red,)
                : MovieList(
                    movieList: popularMovie!,
                    title: "Popular",
                    forHeroTag: "pop"
                  ),
          ],
        ));
  }
}
