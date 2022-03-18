import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviedb/components/search_list.dart';
import 'package:moviedb/controller/home_controller.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextController = TextEditingController();

  final HomeController c = Get.put(HomeController());

  Widget _searchMovieList() => c.searchedMoives.isEmpty
      ? const Text("Search a movie first")
      : SearchList(list: c.searchedMoives);

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
              c.loadSearch(searchTextController.text);
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
        body: Obx(() => _searchMovieList()));
  }
}
