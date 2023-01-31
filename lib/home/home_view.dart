import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_exercises/home/home_view_service.dart';
import 'package:hive_exercises/home/manager/user_cache_manager.dart';
import 'package:hive_exercises/home/model/user_model.dart';
import 'package:hive_exercises/home/search_view/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String baseUrl2 = 'https://jsonplaceholder.typicode.com';
  final String apiMultiAvatar = 'https://api.multiavatar.com';
  List<UserModel>? _items;
  late final ICacheManager<UserModel> cacheManager;
  late final IHomeService _homeService;
  @override
  void initState() {
    _homeService = HomeService(Dio(BaseOptions(baseUrl: baseUrl2)));
    cacheManager = CacheManager('_userCache');
    fetchDatas();
    super.initState();
  }

  void fetchDatas() async {
    await cacheManager.init();

    if (cacheManager.getValues()?.isNotEmpty ?? false) {
      _items = cacheManager.getValues();
    } else {
      _items = await _homeService.fetchUsers();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingAction(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchView(cacheManager: cacheManager),
                  ));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: (_items?.isNotEmpty ?? false)
          ? ListView.builder(
              itemCount: _items!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '$apiMultiAvatar/${_items![index].id}.png',
                      ),
                    ),
                    title: Text(_items![index].name ?? ''),
                  ),
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  FloatingActionButton _buildFloatingAction() {
    return FloatingActionButton(
      child: const Icon(Icons.flutter_dash_outlined),
      onPressed: () async {
        if (_items?.isNotEmpty ?? false) {
          await cacheManager.addItems(_items!);
        }
      },
    );
  }
}
