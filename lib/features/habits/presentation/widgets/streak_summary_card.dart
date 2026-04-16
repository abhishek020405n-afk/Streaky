import 'package:flutter/material.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/habit_model.dart';

class StreakSummaryCard extends StatelessWidget {
  const StreakSummaryCard({super.key, required this.habits});

  final List<HabitModel> habits;

  @override
  Widget build(BuildContext context) {
    final currentStreak = habits.fold<int>(0, (sum, habit) => sum + DateUtilsHelper.currentStreak(habit));
    final longestStreak = habits.fold<int>(0, (sum, habit) => sum + DateUtilsHelper.longestStreak(habit));
    final activeHabits = habits.where((habit) => habit.isActive).length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(label: 'Active', value: activeHabits.toString()),
            _SummaryItem(label: 'Streak', value: '$currentStreak d'),
            _SummaryItem(label: 'Best', value: '$longestStreak d'),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
