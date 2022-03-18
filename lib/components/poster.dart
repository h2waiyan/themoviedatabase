import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/network/api.dart';

class Poster extends StatefulWidget {
  String poster;
  Poster({Key? key, required this.poster}) : super(key: key);

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: API.imageURL + widget.poster,
      placeholder: ((context, url) => Image.asset('assets/movie_loading.png')),
    );
  }
}
