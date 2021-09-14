import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future sendinfuture(DateTime datetime, String alarmMessage) async {
    Duration offsetTime = DateTime.now().timeZoneOffset;
    String message = alarmMessage != "" ? alarmMessage : "Its Timeeee......";
    tz.TZDateTime zonedTime = tz.TZDateTime.local(datetime.year, datetime.month,
            datetime.day, datetime.hour, datetime.minute, 0, 0, 0)
        .subtract(offsetTime);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("1", "Alarm App", "Alert User",
            importance: Importance.defaultImportance, priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        message,
        "This notification is triggered by Alarm App",
        zonedTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
