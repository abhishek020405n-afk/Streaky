import '../constants/app_constants.dart';
import '../../features/habits/data/models/habit_model.dart';

class DateUtilsHelper {
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isHabitDue(HabitModel habit, DateTime date) {
    if (!habit.isActive) return false;

    final target = DateTime(date.year, date.month, date.day);
    if (habit.repeatType == RepeatType.once) {
      if (habit.oneTimeDate == null) {
        return false;
      }
      return isSameDay(habit.oneTimeDate!, target);
    }

    if (habit.repeatType == RepeatType.custom && habit.customIntervalDays != null) {
      final elapsed = target.difference(habit.createdAt).inDays;
      return elapsed >= 0 && elapsed % habit.customIntervalDays! == 0;
    }

    if (habit.repeatType == RepeatType.weekly) {
      return habit.repeatWeekdays.contains(target.weekday);
    }

    return habit.repeatType == RepeatType.daily;
  }

  static TaskStatus getStatusForDate(HabitModel habit, DateTime date) {
    final matched = habit.history.where((entry) => isSameDay(entry.date, date));
    return matched.isNotEmpty ? matched.first.status : TaskStatus.pending;
  }

  static int completionPercentage(HabitModel habit) {
    final total = habit.history.length;
    if (total == 0) return 0;
    final completed = habit.history.where((entry) => entry.status == TaskStatus.completed).length;
    return ((completed / total) * 100).round();
  }

  static int currentStreak(HabitModel habit) {
    final today = DateTime.now();
    final ordered = habit.history.where((entry) => entry.status == TaskStatus.completed).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    if (ordered.isEmpty) return 0;

    var streak = 0;
    var cursor = DateTime(today.year, today.month, today.day);

    while (true) {
      final completedToday = ordered.any((entry) => isSameDay(entry.date, cursor));
      if (completedToday) {
        streak += 1;
        cursor = cursor.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  static int longestStreak(HabitModel habit) {
    if (habit.history.isEmpty) return 0;
    final completedDays = habit.history
        .where((entry) => entry.status == TaskStatus.completed)
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
        .toSet()
        .toList()
      ..sort();

    var maxStreak = 0;
    var currentStreak = 0;
    DateTime? previousDay;

    for (final date in completedDays) {
      if (previousDay == null || date.difference(previousDay).inDays > 1) {
        currentStreak = 1;
      } else {
        currentStreak += 1;
      }
      maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
      previousDay = date;
    }
    return maxStreak;
  }

  static String formatRepeatText(HabitModel habit) {
    switch (habit.repeatType) {
      case RepeatType.daily:
        return 'Daily';
      case RepeatType.weekly:
        final names = habit.repeatWeekdays.map((day) => _weekDayName(day)).join(', ');
        return 'Weekly • $names';
      case RepeatType.custom:
        return 'Every ${habit.customIntervalDays ?? 1} days';
      case RepeatType.once:
        return habit.oneTimeDate != null ? 'One time • ${habit.oneTimeDate!.toLocal().toShortDateString()}' : 'One time';
      default:
        return 'Daily';
    }
  }

  static String _weekDayName(int day) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[(day - 1).clamp(0, 6)];
  }
}

extension DateTimeFormatting on DateTime {
  String toShortDateString() {
    return '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/${year.toString()}';
  }
}
