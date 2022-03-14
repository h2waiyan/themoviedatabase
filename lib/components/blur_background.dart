import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviedb/network/api.dart';

import '../models/movie.dart';

class BlurBackground extends StatefulWidget {
  String backdrop_path;
  BlurBackground({Key? key, required this.backdrop_path}) : super(key: key);

  @override
  State<BlurBackground> createState() => _BlurBackgroundState();
}

class _BlurBackgroundState extends State<BlurBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(API.imageURL + widget.backdrop_path),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
