
import 'package:flutter/cupertino.dart';
import 'package:habits_tracker/data/models/user.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, User? user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //nt nbUsers = getCount() as int;
    return Text("Home page.....");
  }
  /*
  Future<int> getCount() async {
    final dbHelper = DatabaseManager.instance;
    int nbUsers = await dbHelper.queryRowCount("tableUsers");
    return nbUsers;
  }*/

}