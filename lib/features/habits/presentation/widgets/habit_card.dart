import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/habit_model.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.habit,
    required this.status,
    required this.onStatusChanged,
    required this.onEdit,
    required this.onDelete,
  });

  final HabitModel habit;
  final TaskStatus status;
  final ValueChanged<TaskStatus> onStatusChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(habit.title, style: Theme.of(context).textTheme.titleMedium),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('${habit.category} • ${DateUtilsHelper.formatRepeatText(habit)}', style: Theme.of(context).textTheme.bodyMedium),
            if (habit.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(habit.notes, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _StatusChip(label: 'Done', selected: status == TaskStatus.completed, onTap: () => onStatusChanged(TaskStatus.completed)),
                    const SizedBox(width: 8),
                    _StatusChip(label: 'Skip', selected: status == TaskStatus.skipped, onTap: () => onStatusChanged(TaskStatus.skipped)),
                    const SizedBox(width: 8),
                    _StatusChip(label: 'Fail', selected: status == TaskStatus.failed, onTap: () => onStatusChanged(TaskStatus.failed)),
                  ],
                ),
                Text(status.name.toUpperCase(), style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
