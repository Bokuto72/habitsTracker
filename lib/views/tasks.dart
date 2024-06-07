import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DatabaseManager databaseManager = DatabaseManager.instance;
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> categories = [];

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();
  String? selectedCategory;
  Color? selectedColor;
  DateTime? _deadline;

  @override
  void initState() {
    _query();
    _fetchTasks();
    _fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              child: Text('Ajouter une tâche'),
              onPressed: () {
                _showAddTask(context);
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        child: ListTile(
                          title: Text(task['label']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description : ${task['desc']}"),
                              IconButton(
                                  onPressed: () {
                                    print("check1");
                                    _validateTask();
                                    print("check2");
                                  },
                                  icon: Icon(Icons.check)
                              )
                            ],
                          ),
                        ),
                      );
                    })
            )
          ],
        )
    );

  }

  void _fetchTasks() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableTasks);
    setState(() {
      tasks = rows;
    });
  }

  void _fetchCategories() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableCategories);
    setState(() {
      categories = rows;
    });
  }

  void _showAddTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
            return AlertDialog(
                title: Text("Ajouter une tâche"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _labelController,
                      decoration: InputDecoration(labelText: 'Titre'),
                    ),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    /*DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['name'],
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: Color(category['color']),
                              ),
                              SizedBox(width: 8),
                              Text(category['name']),
                            ],
                          ),
                        );
                      }).toList()
                        ..add(
                            DropdownMenuItem<String>(
                                value: 'new',
                                child: Text('Créer une nouvelle catégorie')
                            )
                        ),
                      onChanged: (value) {
                        if(value == 'new') {
                          _showAddCategory(context, setState);
                        } else {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                      decoration: InputDecoration(labelText: 'Catégorie'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Date butoire (optionnelle)'),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _deadline = pickedDate;
                          });
                        }
                      },
                      controller: TextEditingController(
                        text: _deadline != null ? DateFormat.yMMMd().format(_deadline!) : '',
                      ),
                    ),*/
                  ],
                ),
              actions: [
                TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Ajouter'),
                  onPressed: () {
                    _addTask();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            }
          );
        }
    );
  }

  void _addTask() async {
    final String label = _labelController.text;
    final String description = _descController.text;
    //final String? category = selectedCategory.
    var category = null;
    final String? deadline = _deadline != null ? _deadline!.toIso8601String() : null;

    Map<String, dynamic> task = {
      'label': label,
      'desc': description,
      'category': category,
      'deadline': deadline
    };


    await databaseManager.insert(DatabaseManager.tableTasks, task);
    _fetchTasks();
    print("task ajoutée à la bdd");
    _labelController.clear();
    _descController.clear();
    selectedCategory = null;
    _deadline = null;
  }

  void _showAddCategory(BuildContext context, StateSetter setState) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Catégories"),
              content: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Catégorie'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showColorPicker(context, setState);
                      },
                      child: Text('Choisir une couleur')
                  ),
                  if (selectedColor != null)
                    Container(
                      width: 50,
                      height: 50,
                      color: selectedColor,
                    ),
                ],
              ),
            actions: [
              TextButton(
                child: Text('Ajouter'),
                onPressed: () {
                  final newCategory = _categoryController.text;
                  setState(() {
                    categories.add({
                      'name': newCategory,
                      'color': selectedColor?.value ?? Colors.black.value,
                    });
                    selectedCategory = newCategory;
                    _categoryController.clear();
                    selectedColor = null;
                  });
                  _addCategoryToDatabase(newCategory, selectedColor?.value ?? Colors.black.value);
                  Navigator.of(context).pop();
                },
              )
            ],

          );
        }
    );
  }

  void _showColorPicker(BuildContext context, StateSetter setState) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ColorPicker(
              pickerColor: selectedColor ?? Colors.black,
              onColorChanged: (Color value) {
                setState(() {
                  print("couleur choisie" + value.toString());
                  selectedColor = value;
                });
              }),
            actions: [
              TextButton(
                child: Text('Valider'),
                onPressed: () {
                  print("choix couleur");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  void _addCategoryToDatabase(String name, int color) async {
    final newCategory = {'name': name, 'color': color};
    await databaseManager.insert(DatabaseManager.tableCategories, newCategory);
    _fetchCategories();
    print("catégorie ajoutée à la bdd");
  }

  void _validateTask() async {
    const int xpReward = 10;
    Map<String, dynamic> user = users.first;

    if ((user['xp']! + xpReward) >= 50) {
      user['level'] = user['level']! + 1;
      user['xp'] = ((user['xp']! + xpReward)% 50);
    } else {
      user['xp'] = user['xp']! + xpReward;
    }

    await databaseManager.update(DatabaseManager.tableUsers, user);
    print("user mis à jur");
  }

  void _query() async {
    final rows = await databaseManager.queryAllRows(DatabaseManager.tableUsers);
    setState(() {
      users = rows;
    });
  }

  void updateXp(int xpReward) {

  }
}