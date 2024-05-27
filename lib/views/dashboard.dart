
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data/database.dart';

import '../data/models/user.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              child: ListTile(
                title: Text(user['pseudo']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("vie: ${user['health']}"),
                    Text("niv: ${user['level']}"),
                    Text("xp: ${user['xp']}")
                  ],
                ),
              ),
            );
          })

      );

  }

  void _query() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableUsers);
    setState(() {
      users = rows;
    });
  }

  void _update() async {
    
  }
}