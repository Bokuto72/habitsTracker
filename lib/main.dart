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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? _page;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    DatabaseManager dbManager = DatabaseManager.instance;
    int userCount = await dbManager.queryRowCount(DatabaseManager.tableUsers);
    setState(() {
      _page = userCount == 0 ? const UserCreation() : const HomePage();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitsTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _page ?? const Center(child: CircularProgressIndicator())
    );
  }
}
