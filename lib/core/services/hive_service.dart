import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../../features/habits/data/models/habit_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    await Future.wait([
      Hive.openBox<HabitModel>(AppConstants.habitsBoxName),
      Hive.openBox(AppConstants.settingsBoxName),
    ]);
  }

  static Box<HabitModel> get habitsBox => Hive.box<HabitModel>(AppConstants.habitsBoxName);
  static Box get settingsBox => Hive.box(AppConstants.settingsBoxName);
}
