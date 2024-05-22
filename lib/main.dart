import 'package:flutter/material.dart';
import 'package:habits_tracker/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // TODO
    //S'il n'y a pas d'user enregistré,
    //=> page de création de compte.
    //Après création de compte ou si un compte est enregistré,
    //=> page d'accueil standard.
    

    return MaterialApp(
      title: 'HabitsTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage()
    );
  }
}
