
import 'package:flutter/cupertino.dart';
import 'package:habits_tracker/controllers/user_controller.dart';
import 'package:habits_tracker/data/database.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({super.key});

  @override
  State<UserCreation> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Text("Création d'utilisateur");
  }
  
}