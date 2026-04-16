import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/habit_model.dart';
import '../providers/habit_providers.dart';
import '../widgets/habit_card.dart';
import '../widgets/streak_summary_card.dart';
import 'habit_editor_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitStreamProvider);
    final actions = ref.read(habitActionsProvider);

    return habitsAsync.when(
      data: (habits) {
        final totalHabits = habits.length;
        final completedCount = habits.where((habit) {
          return DateUtilsHelper.getStatusForDate(habit, DateTime.now()) == TaskStatus.completed;
        }).length;
        final progress = totalHabits == 0 ? 0 : ((completedCount / totalHabits) * 100).round();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreakSummaryCard(habits: habits),
                const SizedBox(height: 16),
                Text('Today’s progress', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress / 100, minHeight: 10),
                const SizedBox(height: 10),
                Text('$progress% complete • $completedCount of $totalHabits habits done', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                Expanded(
                  child: habits.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.celebration, size: 72, color: Colors.blueAccent),
                              SizedBox(height: 16),
                              Text('No habits yet. Create your first habit to start building streaks.', textAlign: TextAlign.center),
                            ],
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: habits.length,
                          onReorder: (oldIndex, newIndex) async {
                            final updated = List<HabitModel>.from(habits);
                            final item = updated.removeAt(oldIndex);
                            updated.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
                            await actions.reorderHabits(updated);
                          },
                          itemBuilder: (context, index) {
                            final habit = habits[index];
                            final todayStatus = DateUtilsHelper.getStatusForDate(habit, DateTime.now());
                            return HabitCard(
                              key: ValueKey(habit.id),
                              habit: habit,
                              status: todayStatus,
                              onStatusChanged: (status) async {
                                final newHistory = habit.history.where((entry) => !DateUtilsHelper.isSameDay(entry.date, DateTime.now())).toList();
                                newHistory.add(TaskModel(date: DateTime.now(), status: status, notes: habit.notes));
                                final updatedHabit = habit.copyWith(history: newHistory);
                                await actions.saveHabit(updatedHabit);
                              },
                              onEdit: () async {
                                await Navigator.of(context).push(MaterialPageRoute(builder: (_) => HabitEditorScreen(habit: habit)));
                              },
                              onDelete: () async {
                                await actions.deleteHabit(habit.id);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Unable to load habits. ${error.toString()}')),
    );
  }
}
