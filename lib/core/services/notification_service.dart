import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../constants/app_constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSettings = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings: settings);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleDate,
  }) async {
    final scheduled = tz.TZDateTime.from(scheduleDate, tz.local);
    final androidDetails = AndroidNotificationDetails(
      AppConstants.channelId,
      AppConstants.channelName,
      channelDescription: AppConstants.channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    final iosDetails = DarwinNotificationDetails();
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleDailySummary({required int hour, required int minute}) async {
    final now = DateTime.now();
    final scheduleDate = DateTime(now.year, now.month, now.day, hour, minute);
    final normalized = scheduleDate.isBefore(now) ? scheduleDate.add(const Duration(days: 1)) : scheduleDate;

    await scheduleNotification(
      id: 1000,
      title: 'Daily Habit Summary',
      body: 'Check your streaks, review today’s habits, and keep your progress moving forward.',
      scheduleDate: normalized,
    );
  }

  static Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}
