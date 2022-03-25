import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  late SearchBar searchBar;

  @override
  void initState() {
    super.initState();
    initSearchBar();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('My Home Page'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void initSearchBar() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
    );
  }
}
