
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/data/models/user.dart';
import 'package:habits_tracker/views/agenda.dart';
import 'package:habits_tracker/views/dashboard.dart';
import 'package:habits_tracker/views/rewards.dart';
import 'package:habits_tracker/views/tasks.dart';

import '../data/database.dart';
import 'components/bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, User? user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavbar(),
      child: HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  State<HomePageContent> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageContent> {
  DatabaseManager dbManager = DatabaseManager.instance;

  final _pageNavigation = [
    //const DashboardPage(),
    const TasksPage(),
    const AgendaPage(),
    const RewardsPage()
  ];

  // TODO
  // Afficher le dashboard en haut;
  // la page choisie par la navbar en bas.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbar, int>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const DashboardPage(),
              ),
              Expanded(
                  child: _buildBody(state)
              )
            ],
          ),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: context.read<BottomNavbar>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      items: const [
        //BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Tâches"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Agenda"),
        BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Recompenses"),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavbar>().updateIndex(index);
  }
}