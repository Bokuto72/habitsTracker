
import 'package:habits_tracker/data/models/category.dart';

class Task {
  Task({
    this.id,
    this.label,
    this.category,
    this.hour
  });

  final int? id;
  final String? label;
  final Category? category;
  final String? hour;
}