import 'package:flutter/material.dart';
import 'package:hive_exercises/home/manager/user_cache_manager.dart';

import '../model/user_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.cacheManager}) : super(key: key);

  final ICacheManager<UserModel> cacheManager;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<UserModel> _items = [];

  void findAndSet(String key) {
    _items = widget.cacheManager.getValues()?.where((element) => element.name!.contains(key)).toList() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) {
              findAndSet(value);
            },
          ),
        ),
        body: Text(_items.map((e) => '${e.name} - ${e.company}').join(', ')));
  }
}
