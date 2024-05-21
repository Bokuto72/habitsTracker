
import 'package:habits_tracker/data/models/reward.dart';

class User {
  User({
    this.pseudo,
    this.level,
    this.xp,
    this.health,
    this.rewards,
  });

  final String? pseudo;
  final int? level;
  final int? xp;
  final int? health;
  final List<Reward>? rewards;


}