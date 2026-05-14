import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:babysteps/core/network/notification_service.dart';

class MockFlutterLocalNotificationsPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

void main() {
  late NotificationService notificationService;
  late MockFlutterLocalNotificationsPlugin mockPlugin;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(tz.TZDateTime.now(tz.local));
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(AndroidScheduleMode.exactAllowWhileIdle);
  });

  setUp(() {
    mockPlugin = MockFlutterLocalNotificationsPlugin();
    notificationService = NotificationService(plugin: mockPlugin);
  });

  group('NotificationService', () {
    test('scheduleReminder calls plugin.zonedSchedule', () async {
      when(() => mockPlugin.zonedSchedule(
            id: any(named: 'id'),
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
          )).thenAnswer((_) async {});

      final scheduledTime = DateTime.now().add(const Duration(hours: 1));
      
      await notificationService.scheduleReminder(
        1,
        'Medication Reminder',
        'Time for Vitamin D',
        scheduledTime,
      );

      verify(() => mockPlugin.zonedSchedule(
            id: 1,
            title: 'Medication Reminder',
            body: 'Time for Vitamin D',
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          )).called(1);
    });
  });
}

