
import 'package:habits_tracker/data/models/category.dart';

class Task {
  Task({
    this.id,
    this.label,
    this.desc,
    this.category,
    this.deadline
  });

  final int? id;
  final String? label;
  final String? desc;
  final Category? category;
  final String? deadline;

  // TODO
  // gérer l'accès à l'id de la catégorie.

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'label': label,
      'desc': desc,
      'category': category?.id,
      'deadline': deadline
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, label: $label, desc: $desc, deadline: $deadline}';
  }
}