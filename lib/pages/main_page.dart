import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedb/controller/home_controller.dart';
import 'package:moviedb/pages/search_page.dart';

import '../components/movie_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController c = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    c.loadNowPlaying();
    c.loadPopular();
  }

  Widget _nowPlayingMovies() => c.nowPlayingMovies.isEmpty
      ? const CircularProgressIndicator(
          color: Colors.red,
        )
      : MovieList(
          movieList: c.nowPlayingMovies,
          title: "In Theatre",
          forHeroTag: "now");

  Widget _popularMoives() => c.popularMovies.isEmpty
      ? const CircularProgressIndicator(
          color: Colors.red,
        )
      : MovieList(
          movieList: c.popularMovies, title: "Popular", forHeroTag: "pop");

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
        body: Obx(() {
          return Column(children: [_nowPlayingMovies(), _popularMoives()]);
        }));
  }
}
