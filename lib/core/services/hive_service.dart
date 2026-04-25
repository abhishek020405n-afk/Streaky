import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../../features/habits/data/models/habit_model.dart';

class HiveService {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();

    // Register adapters only if not already registered
    if (!Hive.isAdapterRegistered(HabitModelAdapter().typeId)) {
      Hive.registerAdapter(HabitModelAdapter());
    }
    if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
      Hive.registerAdapter(TaskModelAdapter());
    }

    await Future.wait([
      Hive.openBox<HabitModel>(AppConstants.habitsBoxName),
      Hive.openBox(AppConstants.settingsBoxName),
    ]);

    _initialized = true;
  }

  static Box<HabitModel> get habitsBox => Hive.box<HabitModel>(AppConstants.habitsBoxName);
  static Box get settingsBox => Hive.box(AppConstants.settingsBoxName);
}
