import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../constants/app_constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      tz.initializeTimeZones();
      // Safely set local timezone - fallback to UTC if it fails
      try {
        tz.setLocalLocation(tz.local);
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('UTC'));
      }

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

      await _plugin.initialize(settings: settings);
    } catch (e) {
      // Notifications failed to initialize - app continues without notifications
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleDate,
  }) async {
    try {
      final scheduled = tz.TZDateTime.from(scheduleDate, tz.local);
      final androidDetails = AndroidNotificationDetails(
        AppConstants.channelId,
        AppConstants.channelName,
        channelDescription: AppConstants.channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      const iosDetails = DarwinNotificationDetails();
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduled,
        notificationDetails: NotificationDetails(android: androidDetails, iOS: iosDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      // Ignore notification scheduling errors
    }
  }

  static Future<void> scheduleDailySummary({required int hour, required int minute}) async {
    try {
      final now = DateTime.now();
      final scheduleDate = DateTime(now.year, now.month, now.day, hour, minute);
      final normalized = scheduleDate.isBefore(now)
          ? scheduleDate.add(const Duration(days: 1))
          : scheduleDate;

      await scheduleNotification(
        id: 1000,
        title: 'Daily Habit Summary',
        body: 'Check your streaks and keep your progress moving forward!',
        scheduleDate: normalized,
      );
    } catch (e) {
      // Ignore
    }
  }

  static Future<void> cancelAllNotifications() async {
    try {
      await _plugin.cancelAll();
    } catch (e) {
      // Ignore
    }
  }
}
