
import 'package:habits_tracker/data/models/day.dart';

import 'category.dart';

class Habit {
  Habit({
    this.id,
    this.label,
    this.desc,
    this.category,
    this.startingTime,
    this.endingTime,
    this.repeatingDays,
  });

  final int? id;
  final String? label;
  final String? desc;
  final Category? category;
  final String? startingTime;
  final String? endingTime;
  final List<Day>? repeatingDays;
}