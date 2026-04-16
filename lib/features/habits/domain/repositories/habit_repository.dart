import '../../data/models/habit_model.dart';

abstract class HabitRepository {
  Stream<List<HabitModel>> watchHabits();
  Future<void> saveHabit(HabitModel habit);
  Future<void> deleteHabit(String id);
  Future<void> reorderHabits(List<HabitModel> habits);
  Future<void> importHabits(List<Map<String, dynamic>> payload);
}
