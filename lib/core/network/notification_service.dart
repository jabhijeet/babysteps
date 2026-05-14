import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
      : flutterLocalNotificationsPlugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  Future<void> scheduleReminder(int id, String title, String body, DateTime scheduledDate) async {
    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'babysteps_reminders',
      'Reminders',
      channelDescription: 'Notifications for baby reminders (medicines, appointments)',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzScheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleWakeWindowReminder(int babyId, DateTime lastSleepEndTime, int wakeWindowMinutes) async {
    final scheduledTime = lastSleepEndTime.add(Duration(minutes: wakeWindowMinutes));
    
    await scheduleReminder(
      babyId * 1000 + 1, // Unique ID for wake window
      'Sleep Reminder',
      'It has been $wakeWindowMinutes minutes since last sleep. Time for a nap?',
      scheduledTime,
    );
  }

  Future<void> cancelReminder(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }
}






