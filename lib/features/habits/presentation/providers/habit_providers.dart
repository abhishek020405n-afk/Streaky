import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/notification_service.dart';
import '../../data/datasources/local_habit_data_source.dart';
import '../../data/models/habit_model.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/repositories/habit_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepositoryImpl(LocalHabitDataSource());
});

final habitStreamProvider = StreamProvider<List<HabitModel>>((ref) {
  return ref.watch(habitRepositoryProvider).watchHabits();
});

final habitActionsProvider = Provider<HabitActions>((ref) {
  return HabitActions(ref.watch(habitRepositoryProvider));
});

class HabitActions {
  HabitActions(this._repository);

  final HabitRepository _repository;

  Future<void> saveHabit(HabitModel habit) async {
    await _repository.saveHabit(habit);
    await NotificationService.scheduleDailySummary(hour: 20, minute: 0);
  }

  Future<void> deleteHabit(String id) async {
    await _repository.deleteHabit(id);
  }

  Future<void> reorderHabits(List<HabitModel> habits) async {
    final ordered = habits.asMap().entries.map((entry) {
      final item = entry.value;
      return item.copyWith(order: entry.key);
    }).toList();

    await _repository.reorderHabits(ordered);
  }

  Future<void> importHabits(List<Map<String, dynamic>> payload) async {
    await _repository.importHabits(payload);
  }
}
