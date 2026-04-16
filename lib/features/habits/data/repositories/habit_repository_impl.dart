import '../../domain/repositories/habit_repository.dart';
import '../datasources/local_habit_data_source.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this._localDataSource);

  final LocalHabitDataSource _localDataSource;

  @override
  Future<void> deleteHabit(String id) async {
    await _localDataSource.deleteHabit(id);
  }

  @override
  Stream<List<HabitModel>> watchHabits() {
    return _localDataSource.watchHabits();
  }

  @override
  Future<void> saveHabit(HabitModel habit) async {
    await _localDataSource.saveHabit(habit);
  }

  @override
  Future<void> reorderHabits(List<HabitModel> habits) async {
    await _localDataSource.reorderHabits(habits);
  }

  @override
  Future<void> importHabits(List<Map<String, dynamic>> payload) async {
    await _localDataSource.importJson(payload);
  }
}
