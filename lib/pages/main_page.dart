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

  loadMovie() {
    API().getNowPlaying().then((value) {
      setState(() {
        nowPlayingMovie = value;
      });
    });

    API().getPopular().then((value) {
      setState(() {
        popularMovie = value;
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
            nowPlayingMovie == null
                ? const Text("Loading")
                : ListUI(
                    movieList: nowPlayingMovie!,
                    title: "On Theatre",
                  ),
            popularMovie == null
                ? const Text("Loading")
                : ListUI(
                    movieList: popularMovie!,
                    title: "Popular",
                  ),
          ],
        ));
  }
}
