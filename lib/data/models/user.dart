
import 'package:habits_tracker/data/models/reward.dart';

class User {
  User({
    this.id,
    this.pseudo,
    this.level,
    this.xp,
    this.health,
    this.rewards,
  });

  final int? id;
  final String? pseudo;
  int? level;
  int? xp;
  final int? health;
  final List<Reward>? rewards;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
      'level': level,
      'xp': xp,
      'health': health
    };
  }

  @override
  String toString() {
    return 'User{id: $id, pseudo: $pseudo, level: $level, xp: $xp, health: $health}';
  }

}