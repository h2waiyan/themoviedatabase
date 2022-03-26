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

  late FocusNode myfocusNode;
  var isFocus = false;

  @override
  void initState() {
    myfocusNode = FocusNode();
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      myfocusNode.requestFocus();
    });
    myfocusNode.addListener(() {
      setState(() {
        isFocus = myfocusNode.hasFocus;
        print(isFocus);
      });
    });
  }

  Widget _searchMovieList() => c.searchedMoives.isEmpty
      ? const Text("Search a movie first")
      : SearchList(list: c.searchedMoives);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                  onPressed: (() {
                    if (isFocus) {
                      myfocusNode.unfocus();
                      searchTextController.clear();
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  child: Text(
                    isFocus ? "Cancel" : "Close",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
            title: SizedBox(
              height: 45,
              child: TextField(
                focusNode: myfocusNode,
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
