
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data/models/user.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, User? user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseManager dbManager = DatabaseManager.instance;

  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.calendar_month),
    Icon(Icons.add),
    Icon(Icons.attach_money)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Accueil',
            icon : Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Agenda',
            icon : Icon(Icons.calendar_month)
          ),
          BottomNavigationBarItem(
            label: 'Ajouter',
            icon : Icon(Icons.add)
          ),
          BottomNavigationBarItem(
            label: 'Rewards',
            icon : Icon(Icons.attach_money)
          )
        ],
      ),
    );
  }



}