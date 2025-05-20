import 'package:english_mind_demo/data/models/streak_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class StreakObjectBox {
  @Id()
  int id = 0;
  String userId;
  @Backlink('streak')
  final streakDays = ToMany<StreakDayObjectBox>();

  StreakObjectBox({required this.userId});

  Streak toStreak() {
    return Streak(
      userId: userId,
      activeDays: streakDays.map((day) => day.timestamp).toSet(),
    );
  }

  static StreakObjectBox fromStreak(Streak streak) {
    final obj = StreakObjectBox(userId: streak.userId);
    obj.streakDays.addAll(streak.activeDays.map(StreakDayObjectBox.new));
    return obj;
  }
}

@Entity()
class StreakDayObjectBox {
  @Id()
  int id = 0;
  int timestamp; // Unix timestamp (start of the day)
  final streak = ToOne<StreakObjectBox>();

  StreakDayObjectBox(this.timestamp);
}
