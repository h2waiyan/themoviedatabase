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
            title: SizedBox(
          height: 45,
          child: TextField(
            cursorHeight: 34,
            controller: searchTextController,
            style: const TextStyle(color: Colors.black),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              API().getSearch(searchTextController.text).then((value) {
                setState(() {
                  searchResult = value;
                });
              });
            },
            decoration: InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Enter a movie name',
              hintStyle: const TextStyle(color: Colors.black),
            ),
          ),
        )),
        body: searchResult == null
            ? const Text("Search a movie first")
            : SearchList(list: searchResult!));
  }
}
