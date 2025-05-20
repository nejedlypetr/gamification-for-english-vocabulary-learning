import 'package:english_mind_demo/data/models/streak_model.dart';

abstract class StreakRepository {
  Future<void> saveStreak(Streak streak);
  Future<Streak?> getStreak(String userId);
}
