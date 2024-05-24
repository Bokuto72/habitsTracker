import 'package:flutter/material.dart';
import 'package:habits_tracker/views/home.dart';
import 'package:habits_tracker/views/user_creation.dart';
import 'package:sqflite/sqflite.dart';

import 'data/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget? page;

    //S'il n'y a pas d'user enregistré,
    //=> page de création de compte.
    //Après création de compte ou si un compte est enregistré,
    //=> page d'accueil standard.

    DatabaseManager dbHelper = DatabaseManager.instance;
    if(dbHelper.queryRowCount("tableUsers").then((value) {return value;}) == 0) {
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
