import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../features/habits/data/models/habit_model.dart';

class BackupService {
  static Future<bool> exportHabits(List<HabitModel> habits) async {
    final jsonString = jsonEncode(habits.map((habit) => habit.toJson()).toList());

    try {
      final path = await FilePicker.saveFile(
        dialogTitle: 'Export HabitFlow Backup',
        fileName: 'habitflow_backup_${DateTime.now().millisecondsSinceEpoch}.json',
      );
      if (path == null) {
        return false;
      }

      final file = File(path);
      await file.writeAsString(jsonString);
      return true;
    } catch (error) {
      await SharePlus.instance.share(ShareParams(text: jsonString, title: 'HabitFlow Backup'));
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> importHabits() async {
    final result = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result == null || result.files.isEmpty) {
      return null;
    }

    final filePath = result.files.single.path;
    if (filePath == null) {
      return null;
    }

    final file = File(filePath);
    final raw = await file.readAsString();
    return List<Map<String, dynamic>>.from(jsonDecode(raw) as List<dynamic>);
  }
}
