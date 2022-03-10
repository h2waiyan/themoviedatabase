import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../network/api.dart';

class ListUI extends StatefulWidget {
  List<Movie> movieList;
  String title;
  ListUI({
    Key? key,
    required this.movieList,
    required this.title,
  }) : super(key: key);

  @override
  State<ListUI> createState() => _ListUIState();
}

class _ListUIState extends State<ListUI> {
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
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.movieList.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie m = widget.movieList[index];

                  return SizedBox(
                    width: 125,
                    height: 217,
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.network(API.imageURL + m.posterPath),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
