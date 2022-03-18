import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedb/components/poster.dart';
import '../models/movie.dart';
import '../pages/detail_page.dart';

class MovieList extends StatefulWidget {
  List<Movie> movieList;
  String title;
  String forHeroTag;
  MovieList(
      {Key? key,
      required this.movieList,
      required this.title,
      required this.forHeroTag})
      : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 228,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.movieList.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie m = widget.movieList[index];

                  return InkWell(
                    onTap: () {
                      Get.to(DetailPage(
                          movie: m, idx: "${widget.forHeroTag}${m.id}"));
                    },
                    child: Container(
                      width: 125,
                      height: 125,
                      child: Card(
                        color: Colors.grey[300],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Hero(
                                tag: "${widget.forHeroTag}${m.id}",
                                // tag: "post",
                                child: SizedBox(
                                  height: 175,
                                  width: 125,
                                  child: Poster(poster: m.posterPath!),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                m.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
