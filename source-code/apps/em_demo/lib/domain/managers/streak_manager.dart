import 'package:english_mind_demo/core/extensions/extensions.dart';
import 'package:english_mind_demo/data/models/flashcard_srs_metadata.dart';
import 'package:english_mind_demo/data/models/streak_model.dart';
import 'package:english_mind_demo/domain/repositories/streak_repository.dart';
import 'package:flutter/widgets.dart';

class StreakManager {
  final StreakRepository _streakRepository;
  final Map<String, int> _currentStreakCache = {};

  StreakManager({
    required StreakRepository streakRepository,
  }) : _streakRepository = streakRepository;

  Future<bool> updateStreak(FlashcardSrsMetadata metadata) async {
    if (metadata.seenIndex == 0 &&
        metadata.startedLearningAt.isSameYearMonthDay(DateTime.now())) {
      return increaseStreak(''); // TODO: get user id
    }

    return false;
  }

  Future<bool> increaseStreak(String userId) async {
    final streak = await _streakRepository.getStreak(userId);
    final today = Streak.dateToUnix(DateTime.now());

    if (streak == null) {
      debugPrint('Updating streak to 1.');
      final newStreak = Streak(userId: userId, activeDays: {today});
      _updateCurrentStreakCache(userId, 1);

      await _streakRepository.saveStreak(newStreak);
      return true;
    }

    if (streak.isActive) {
      return false;
    }

    debugPrint('Updating streak to ${streak.currentStreak + 1}.');
    streak.activeDays.add(today);
    _updateCurrentStreakCache(userId, streak.currentStreak);

    await _streakRepository.saveStreak(streak);
    return true;
  }

  Future<int> getCurrentStreak(String userId) async {
    if (_currentStreakCache.containsKey(userId)) {
      return _currentStreakCache[userId] ?? 0;
    }

    final streak = await _streakRepository.getStreak(userId);
    final currentStreak = streak?.currentStreak ?? 0;
    _updateCurrentStreakCache(userId, currentStreak);

    return currentStreak;
  }

  Future<bool> isStreakActive(String userId) async {
    final streak = await _streakRepository.getStreak(userId);
    return streak?.isActive ?? false;
  }

  Future<List<bool>> getWeeklyStreakData(String userId) async {
    final streak = await _streakRepository.getStreak(userId);
    if (streak == null) {
      return List.filled(7, false);
    }

    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final weeklyStreak = List<bool>.filled(7, false);

    for (var i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final dayUnix = Streak.dateToUnix(day);
      if (streak.activeDays.contains(dayUnix)) {
        weeklyStreak[i] = true;
      }
    }

    return weeklyStreak;
  }

  void _updateCurrentStreakCache(String userId, int streak) {
    _currentStreakCache[userId] = streak;
  }
}
