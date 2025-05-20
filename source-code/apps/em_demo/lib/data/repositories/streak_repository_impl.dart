import 'package:english_mind_demo/data/datasources/local/streak_box.dart';
import 'package:english_mind_demo/data/models/streak_model.dart';
import 'package:english_mind_demo/domain/repositories/streak_repository.dart';
import 'package:english_mind_demo/objectbox.g.dart';

class StreakRepositoryObjectBoxImpl implements StreakRepository {
  final Box<StreakObjectBox> _streakBox;

  StreakRepositoryObjectBoxImpl({required Box<StreakObjectBox> streakBox})
      : _streakBox = streakBox;

  @override
  Future<void> saveStreak(Streak streak) async {
    final existing = _streakBox
        .query(StreakObjectBox_.userId.equals(streak.userId))
        .build()
        .findFirst();
    final obj = StreakObjectBox.fromStreak(streak);

    if (existing != null) {
      obj.id = existing.id; // Keep the same ID to update
    }

    _streakBox.put(obj);
  }

  @override
  Future<Streak?> getStreak(String userId) async {
    const mockUserId = '';
    final obj = _streakBox
        .query(StreakObjectBox_.userId.equals(mockUserId))
        .build()
        .findFirst();
    return obj?.toStreak();
  }
}
