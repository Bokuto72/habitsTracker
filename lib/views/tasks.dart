import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/database.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  List<Map<String, dynamic>> tasks = [];

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
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                child: ListTile(
                  title: Text(task['pseudo']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("vie: ${task['health']}"),
                      Text("niv: ${task['level']}"),
                      Text("xp: ${task['xp']}")
                    ],
                  ),
                ),
              );
            })

    );

  }

  void _query() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableTasks);
    setState(() {
      tasks = rows;
    });
  }
}