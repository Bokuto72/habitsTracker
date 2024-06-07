
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/data/database.dart';
import 'package:habits_tracker/views/home.dart';

import '../data/models/user.dart';

class UserCreationScreen extends StatefulWidget {
  const UserCreationScreen({super.key});

  @override
  State<UserCreationScreen> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreationScreen> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  final userController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création du profil',)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Pseudo'),
              TextFormField(
                controller: userController,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Veuillez renseigner un pseudo.';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: () async {
                if(formKey.currentState!.validate()) {
                  User user = User(
                    pseudo: userController.text,
                    level: 1,
                    xp: 0,
                    health: 50,
                  );
                  await databaseManager.insert(DatabaseManager.tableUsers, user.toMap());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage())
                  );
                }
              }, child: Text('Confirmer'))
            ],
          )
        )
      )
    );
  }
  
}