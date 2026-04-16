import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/habit_model.dart';

class HeatmapView extends StatelessWidget {
  const HeatmapView({super.key, required this.habits});

  final List<HabitModel> habits;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(28, (index) => now.subtract(Duration(days: 27 - index)));
    final intensities = days.map((date) {
      final completed = habits.where((habit) {
        return DateUtilsHelper.getStatusForDate(habit, date) == TaskStatus.completed;
      }).length;
      return completed;
    }).toList();

    final maxCompleted = intensities.isEmpty ? 1 : intensities.reduce((a, b) => a > b ? a : b).clamp(1, 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: days.map((date) {
            final index = days.indexOf(date);
            final completed = intensities[index];
            final color = _colorForValue(context, completed, maxCompleted);
            return Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(date.day.toString(), style: Theme.of(context).textTheme.bodySmall),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Low', style: TextStyle(fontSize: 12)),
            Text('High', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Color _colorForValue(BuildContext context, int completed, int max) {
    final opacity = completed == 0 ? 0.15 : (0.3 + 0.7 * (completed / max));
    return Theme.of(context).colorScheme.primary.withAlpha((opacity.clamp(0.15, 1.0) * 255).round());
  }
}
