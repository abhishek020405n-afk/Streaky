import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/habit_model.dart';
import '../../../../core/utils/date_utils.dart';
import '../providers/habit_providers.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  static const _challengeTiles = [
    _ChallengeTile(title: '7-day streak', goal: AppConstants.streakMilestone7),
    _ChallengeTile(title: '30-day streak', goal: AppConstants.streakMilestone30),
    _ChallengeTile(title: '100-day streak', goal: AppConstants.streakMilestone100),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitStreamProvider);

    return habitsAsync.when(
      data: (habits) {
        final totalXp = habits.fold<int>(0, (sum, habit) => sum + habit.xp + DateUtilsHelper.currentStreak(habit) * 2);
        final completedHabits = habits.where((habit) => DateUtilsHelper.getStatusForDate(habit, DateTime.now()) == TaskStatus.completed).length;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gamification', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total XP', style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 8),
                            Text('$totalXp XP', style: Theme.of(context).textTheme.displaySmall),
                          ],
                        ),
                        const Icon(Icons.star, size: 40, color: AppTheme.accentColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Today’s challenge', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: const Text('Complete at least one more habit today'),
                    subtitle: Text('$completedHabits completed today'),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Milestones', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                ..._challengeTiles.map((tile) => _buildMilestoneCard(context, tile, habits)).toList(),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Challenges are loading. ${error.toString()}')),
    );
  }

  Widget _buildMilestoneCard(BuildContext context, _ChallengeTile tile, List<HabitModel> habits) {
    final achieved = habits.any((habit) => DateUtilsHelper.currentStreak(habit) >= tile.goal);
    return Card(
      child: ListTile(
        leading: Icon(achieved ? Icons.emoji_events : Icons.flag_outlined, color: achieved ? Colors.amber : Colors.grey),
        title: Text(tile.title),
        subtitle: Text(achieved ? 'Unlocked' : 'Complete a $tile.goal-day streak'),
        trailing: Icon(achieved ? Icons.check_circle : Icons.lock_outline),
      ),
    );
  }
}

class _ChallengeTile {
  const _ChallengeTile({required this.title, required this.goal});
  final String title;
  final int goal;
}
