import 'package:flutter/material.dart';
import 'package:moviedb/components/search_list.dart';
import 'package:moviedb/network/api.dart';

import '../components/movie_list.dart';
import '../models/movie.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchMovie = "Hi";
  List<Movie>? searchResult;
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: searchTextController,
          style: const TextStyle(color: Colors.white),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            API().getSearch(searchTextController.text).then((value) {
              setState(() {
                searchResult = value;
              });
            });
          },
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Enter a movie name',
            hintStyle: TextStyle(color: Colors.white),
          ),
        )),
        body: searchResult == null
            ? const Text("Search a movie first")
            : SearchList(list: searchResult!));
  }
}
