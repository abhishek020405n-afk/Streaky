import 'package:hive/hive.dart';
import '../../../../core/services/hive_service.dart';
import '../models/habit_model.dart';

class LocalHabitDataSource {
  Box<HabitModel> get _box => HiveService.habitsBox;

  List<HabitModel> getAllHabits() {
    final habits = _box.values.toList();
    habits.sort((a, b) => a.order.compareTo(b.order));
    return habits;
  }

  Stream<List<HabitModel>> watchHabits() async* {
    yield getAllHabits();
    await for (final _ in _box.watch()) {
      yield getAllHabits();
    }
  }

  Future<void> saveHabit(HabitModel habit) async {
    await _box.put(habit.id, habit);
  }

  Future<void> deleteHabit(String id) async {
    await _box.delete(id);
  }

  Future<void> reorderHabits(List<HabitModel> habits) async {
    for (final habit in habits) {
      await _box.put(habit.id, habit);
    }
  }

  Future<void> importJson(List<Map<String, dynamic>> payload) async {
    final values = payload.map(HabitModel.fromJson).toList();
    for (final habit in values) {
      await _box.put(habit.id, habit);
    }
  }
}
