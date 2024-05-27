import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data/database.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  List<Map<String, dynamic>> rewards = [];

  @override
  void initState() {
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Récompenses"),
        ),
        body: ListView.builder(
            itemCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return Card(
                child: ListTile(
                  title: Text(reward['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("coût: ${reward['value']}"),

                    ],
                  ),
                ),
              );
            })

    );

  }

  void _query() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableRewards);
    setState(() {
      rewards = rows;
    });
  }
}