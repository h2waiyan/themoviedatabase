import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/components/blur_background.dart';
import 'package:moviedb/components/movie_list.dart';
import 'package:moviedb/models/cast.dart';
import 'package:moviedb/network/api.dart';

import '../models/movie.dart';

class DetailPage extends StatefulWidget {
  Movie movie;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;
  List<Movie> recommendedMovie = [];
  bool recommendLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });

    api.getRecommendedMovie(widget.movie.id).then((value) {
      setState(() {
        recommendedMovie = value;
        recommendLoading = false;
      });
    });
    super.initState();
  }

  _cast_info() => SizedBox(
        // width: double.infinity,
        // height: 200,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: casts!.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Cast c = casts![index];
              return Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: c.profilePath == null
                          ? Container()
                          : CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  API.imageURL + c.profilePath!),
                            )),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.originalName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        c.character,
                        style: TextStyle(color: Colors.white24),
                      ),
                    ],
                  )
                ],
              );
            }),
      );

  _movie_info() => Column(
        children: [
          Hero(
            tag: "${widget.movie.id}",
            child: SizedBox(
              height: 250,
              child: Image(
                  image: CachedNetworkImageProvider(
                      API.imageURL + widget.movie.posterPath)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.overview,
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Stack(
        children: [
          BlurBackground(
            backdrop_path: widget.movie.backdropPath,
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              _movie_info(),
              const SizedBox(
                height: 25,
              ),
              recommendLoading == true
                  ? const CircularProgressIndicator()
                  : MovieList(
                      movieList: recommendedMovie, title: "Recommended Movies"),
              casts == null ? const CircularProgressIndicator() : _cast_info(),
            ],
          ))
        ],
      ),
    );
  }
}
