import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/habit_model.dart';
import '../providers/habit_providers.dart';
import '../widgets/heatmap_view.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitStreamProvider);

    return habitsAsync.when(
      data: (habits) {
        final streaks = habits.map(DateUtilsHelper.currentStreak).toList();
        final highestStreak = streaks.isEmpty ? 0 : streaks.reduce((a, b) => a > b ? a : b);
        final totalHabits = habits.length;
        final activeHabits = habits.where((habit) => habit.isActive).length;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Performance', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                _buildOverviewCard(context, 'Active habits', activeHabits.toString()),
                const SizedBox(height: 12),
                _buildOverviewCard(context, 'Longest streak', '$highestStreak days'),
                const SizedBox(height: 12),
                _buildOverviewCard(context, 'Total habits', '$totalHabits'),
                const SizedBox(height: 20),
                _buildChartSection(context, habits),
                const SizedBox(height: 20),
                Text('Completion heatmap', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                HeatmapView(habits: habits),
                const SizedBox(height: 20),
                _buildProgressList(context, habits),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Analytics unavailable. ${error.toString()}')),
    );
  }

  Widget _buildOverviewCard(BuildContext context, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection(BuildContext context, List<HabitModel> habits) {
    final dates = List.generate(7, (index) => DateTime.now().subtract(Duration(days: 6 - index)));
    final values = dates.map((date) {
      final count = habits.where((habit) {
        final status = DateUtilsHelper.getStatusForDate(habit, date);
        return status == TaskStatus.completed;
      }).length;
      return count.toDouble();
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: true),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, titleMeta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('${dates[index].month}/${dates[index].day}', style: Theme.of(context).textTheme.bodySmall),
                  );
                })),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              minY: 0,
              maxY: values.isEmpty ? 1 : values.reduce((a, b) => a > b ? a : b) + 1,
              lineBarsData: [
                LineChartBarData(
                  spots: values.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value)).toList(),
                  isCurved: true,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: true, color: Colors.blue.withAlpha(51)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressList(BuildContext context, List<HabitModel> habits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent habits', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...habits.take(4).map((habit) {
          final progress = DateUtilsHelper.completionPercentage(habit);
          return Card(
            child: ListTile(
              title: Text(habit.title),
              subtitle: Text('${habit.category} • ${DateUtilsHelper.formatRepeatText(habit)}'),
              trailing: Text('$progress%'),
            ),
          );
        }).toList(),
      ],
    );
  }
}
