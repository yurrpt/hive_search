import 'package:flutter/material.dart';
import 'package:hive_exercises/constants/hive_types.dart';
import 'package:hive_exercises/home/home_view.dart';
import 'package:hive_exercises/home/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
