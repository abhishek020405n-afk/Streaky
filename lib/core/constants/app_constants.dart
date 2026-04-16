/// App-wide constants
class AppConstants {
  // Database
  static const String habitsBoxName = 'habits';
  static const String tasksBoxName = 'tasks';
  static const String streaksBoxName = 'streaks';
  static const String gamificationBoxName = 'gamification';
  static const String reminderBoxName = 'reminders';
  static const String settingsBoxName = 'settings';

  // UI
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 16.0;
  static const double cardBorderRadius = 12.0;

  // Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // Gamification
  static const int xpForCompletion = 10;
  static const int xpForStreak7 = 50;
  static const int xpForStreak30 = 150;
  static const int xpForStreak100 = 500;
  static const int xpPerLevel = 500;

  // Streak
  static const int streakMilestone7 = 7;
  static const int streakMilestone30 = 30;
  static const int streakMilestone100 = 100;

  // Notifications
  static const String channelId = 'streaky_habits';
  static const String channelName = 'Habit Reminders';
  static const String channelDescription = 'Notifications for habit reminders and daily summary';
}

/// Repeat schedule types
enum RepeatType { daily, weekly, biweekly, monthly, custom, once }

/// Task status types
enum TaskStatus { pending, completed, skipped, failed }

/// Category types
enum HabitCategory {
  study('Study', '📚'),
  fitness('Fitness', '💪'),
  health('Health', '🏥'),
  mindfulness('Mindfulness', '🧘'),
  productivity('Productivity', '⚡'),
  social('Social', '👥'),
  learning('Learning', '🎓'),
  creativity('Creativity', '🎨'),
  finance('Finance', '💰'),
  other('Other', '⭐');

  const HabitCategory(this.displayName, this.emoji);
  final String displayName;
  final String emoji;
}

/// Achievement types
enum AchievementType {
  firstHabit('First Habit', 'Create your first habit'),
  week7('7 Day Streak', 'Reach a 7 day streak'),
  month30('30 Day Streak', 'Reach a 30 day streak'),
  century100('100 Day Streak', 'Reach a 100 day streak'),
  tenCompleted('Ten Completed', 'Complete 10 habits'),
  perfectDay('Perfect Day', 'Complete all habits in a day'),
  weekWarrior('Week Warrior', 'Complete all habits for a week'),
  earlyBird('Early Bird', 'Complete a habit before 6 AM'),
  nightOwl('Night Owl', 'Complete a habit after 9 PM'),
  challengeMaster('Challenge Master', 'Complete a daily challenge');

  const AchievementType(this.title, this.description);
  final String title;
  final String description;
}

/// Reminder types
enum ReminderType { before15Min, before1Hour, beforeMidnight, daily, custom }
