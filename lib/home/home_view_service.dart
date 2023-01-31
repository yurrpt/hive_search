import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_exercises/home/model/user_model.dart';

abstract class IHomeService {
  late final Dio _dio;

  final _userPath = '/users';

  IHomeService(Dio dio) : _dio = dio;

  Future<List<UserModel>?> fetchUsers();
}

class HomeService extends IHomeService {
  HomeService(Dio dio) : super(dio);

  @override
  Future<List<UserModel>?> fetchUsers() async {
    final res = await _dio.get<List<dynamic>>(_userPath);
    if (res.statusCode == HttpStatus.ok) {
      return res.data!.map((e) => UserModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
