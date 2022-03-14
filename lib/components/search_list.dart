import 'package:flutter/material.dart';
import 'package:moviedb/network/api.dart';
import 'package:moviedb/pages/detail_page.dart';

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
                        ))));
          },
          child: Row(
            children: [
              SizedBox(
                height: 180,
                child: Image.network(API.imageURL + m.posterPath),
              ),
              Text(m.title)
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
