import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/ad_manager.dart';
import 'core/services/hive_service.dart';
import 'core/services/notification_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await NotificationService.initialize();
  await AdManager.initialize();
  runApp(const ProviderScope(child: HabitFlowApp()));
}
