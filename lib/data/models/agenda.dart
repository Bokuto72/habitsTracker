
import 'package:habits_tracker/data/models/task.dart';

import 'habit.dart';

class Agenda {
  Agenda({
    this.tasks,
    this.habits,
  });

  final List<Task>? tasks;
  final List<Habit>? habits;
}