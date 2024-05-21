
import 'package:habits_tracker/data/models/task.dart';

import 'package:habits_tracker/data/models/day.dart';

class Habit extends Task {
  Habit({
    this.repeatingDays,
  });
  final List<Day>? repeatingDays;
}