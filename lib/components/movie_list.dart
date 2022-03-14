import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../network/api.dart';
import '../pages/detail_page.dart';

class MovieList extends StatefulWidget {
  List<Movie> movieList;
  String title;
  MovieList({
    Key? key,
    required this.movieList,
    required this.title,
  }) : super(key: key);

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
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 245,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.movieList.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie m = widget.movieList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => DetailPage(
                                    movie: m,
                                  ))));
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
                                tag: "${m.id}",
                                child: SizedBox(
                                  height: 175,
                                  child: Image(
                                      image: CachedNetworkImageProvider(
                                          API.imageURL + m.posterPath)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(m.title),
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
