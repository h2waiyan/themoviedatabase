import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/components/poster.dart';
import 'package:moviedb/network/api.dart';
import 'package:moviedb/pages/detail_page.dart';
import 'package:intl/intl.dart';

import '../models/movie.dart';

class SearchList extends StatefulWidget {
  List<Movie> list;
  SearchList({Key? key, required this.list}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (BuildContext contex, int index) {
        Movie m = widget.list[index];

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => DetailPage(
                          movie: m,
                          idx: "search${m.id}",
                        ))));
          },
          child: Row(
            children: [
              Card(
                child: Hero(
                  tag: "search${m.id}",
                  child: SizedBox(
                    height: 175,
                    width: 125,
                    child:
                        // Text("${m.posterPath}")
                        m.posterPath == null
                            ? Image.asset('assets/movie_loading.png')
                            : Poster(poster: m.posterPath!),
                    // Image.network(API.imageURL + m.posterPath),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(m.title),
                  Text(DateFormat('yyyy').format(m.releaseDate!).toString()),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
