import 'package:flutter/material.dart';
import 'package:habits_tracker/views/home.dart';
import 'package:habits_tracker/views/user_creation.dart';

import 'data/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget? page;

    // TODO
    //S'il n'y a pas d'user enregistré,
    //=> page de création de compte.
    //Après création de compte ou si un compte est enregistré,
    //=> page d'accueil standard.

    final dbHelper = DatabaseManager.instance;
    if(dbHelper.queryRowCount("tableUsers") == 0) {
      page = const UserCreation();
    } else {
      page = const HomePage();
    }

    return MaterialApp(
      title: 'HabitsTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: page
    );
  }
}
