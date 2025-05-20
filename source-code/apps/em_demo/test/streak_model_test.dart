import 'package:english_mind_demo/data/models/streak_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Streak Tests', () {
    late Streak streak;
    const testUserId = 'test_user';

    setUp(() {
      streak = Streak(userId: testUserId, activeDays: {});
    });

    test('Empty streak should have zero current streak', () {
      expect(streak.currentStreak, equals(0));
    });

    test('Single day streak should have streak of 1', () {
      final today = Streak.dateToUnix(DateTime.now());
      streak = Streak(userId: testUserId, activeDays: {today});
      expect(streak.currentStreak, equals(1));
    });

    test('Consecutive days streak should be counted correctly', () {
      final now = DateTime.now();
      final today = Streak.dateToUnix(now);
      final yesterday =
          Streak.dateToUnix(now.subtract(const Duration(days: 1)));
      final dayBeforeYesterday =
          Streak.dateToUnix(now.subtract(const Duration(days: 2)));

      streak = Streak(
        userId: testUserId,
        activeDays: {today, yesterday, dayBeforeYesterday},
      );
      expect(streak.currentStreak, equals(3));
    });

    test('Streak should break when there is a gap', () {
      final now = DateTime.now();
      final today = Streak.dateToUnix(now);
      final yesterday =
          Streak.dateToUnix(now.subtract(const Duration(days: 1)));
      final threeDaysAgo =
          Streak.dateToUnix(now.subtract(const Duration(days: 3)));

      streak = Streak(
        userId: testUserId,
        activeDays: {today, yesterday, threeDaysAgo},
      );
      expect(streak.currentStreak, equals(2));
    });

    test('Streak should be 0 when last active day is not today or yesterday',
        () {
      final now = DateTime.now();
      final twoDaysAgo =
          Streak.dateToUnix(now.subtract(const Duration(days: 2)));
      final threeDaysAgo =
          Streak.dateToUnix(now.subtract(const Duration(days: 3)));

      streak = Streak(
        userId: testUserId,
        activeDays: {twoDaysAgo, threeDaysAgo},
      );
      expect(streak.currentStreak, equals(0));
    });

    test('Streak should handle timezone changes correctly', () {
      final now = DateTime.now();
      // Create dates at midnight UTC
      final todayUTC =
          Streak.dateToUnix(DateTime(now.year, now.month, now.day));
      final yesterdayUTC = Streak.dateToUnix(
        DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 1)),
      );

      // Simulate different timezone by creating dates at different times of the same day
      final todayDifferentTZ = Streak.dateToUnix(
        DateTime(now.year, now.month, now.day, 5),
      ); // 5 AM UTC
      final yesterdayDifferentTZ = Streak.dateToUnix(
        DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 1))
            .add(const Duration(hours: 5)),
      );

      streak = Streak(
        userId: testUserId,
        activeDays: {
          todayUTC,
          yesterdayUTC,
          todayDifferentTZ,
          yesterdayDifferentTZ,
        },
      );
      expect(streak.currentStreak, equals(2));
    });

    test('isActive should return true when today is in activeDays', () {
      final today = Streak.dateToUnix(DateTime.now());
      streak = Streak(userId: testUserId, activeDays: {today});
      expect(streak.isActive, isTrue);
    });

    test('isActive should return false when today is not in activeDays', () {
      final yesterday =
          Streak.dateToUnix(DateTime.now().subtract(const Duration(days: 1)));
      streak = Streak(userId: testUserId, activeDays: {yesterday});
      expect(streak.isActive, isFalse);
    });

    test('Historical streak tracking should work with non-consecutive days',
        () {
      final now = DateTime.now();
      final today = Streak.dateToUnix(now);
      final yesterday =
          Streak.dateToUnix(now.subtract(const Duration(days: 1)));
      final lastWeek = Streak.dateToUnix(now.subtract(const Duration(days: 7)));
      final twoWeeksAgo =
          Streak.dateToUnix(now.subtract(const Duration(days: 14)));

      streak = Streak(
        userId: testUserId,
        activeDays: {today, yesterday, lastWeek, twoWeeksAgo},
      );
      expect(streak.currentStreak, equals(2));
      expect(streak.activeDays.length, equals(4));
    });
  });
}
