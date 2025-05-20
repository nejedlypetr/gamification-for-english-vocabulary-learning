class Streak {
  final String userId;
  final Set<int> activeDays; // Unix timestamps (in milliseconds)
  // final Set<int> freezeDays; // Unix timestamps (in milliseconds)

  bool get isActive {
    return activeDays.contains(Streak.dateToUnix(DateTime.now()));
  }

  int get currentStreak {
    if (activeDays.isEmpty) {
      return 0;
    }

    final now = DateTime.now();
    final today = Streak.dateToUnix(now);
    final yesterday = Streak.dateToUnix(now.subtract(const Duration(days: 1)));

    if (!activeDays.contains(today) && !activeDays.contains(yesterday)) {
      return 0;
    }

    final sortedDays = activeDays.toList()..sort((a, b) => b.compareTo(a));
    DateTime? lastDay;
    var currentStreak = 0;

    for (final day in sortedDays) {
      final date = Streak.unixToDate(day);
      if (lastDay == null) {
        lastDay = date;
        currentStreak++;
      } else {
        final difference = lastDay.difference(date).inDays;
        if (difference == 1) {
          currentStreak++;
          lastDay = date;
        } else {
          return currentStreak;
        }
      }
    }

    return currentStreak;
  }

  Streak({required this.userId, required this.activeDays});

  static int dateToUnix(DateTime date) {
    return DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
  }

  static DateTime unixToDate(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
