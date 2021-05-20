import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> repeatNotificationHourly() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('123', 'Auto App', 'sjkdgkjsdbgjkbd');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Auto App',
      'Напомнить вам о поступлении новых автомобилей',
      RepeatInterval.hourly,
      platformChannelSpecifics,
      androidAllowWhileIdle: true);
}

Future<void> repeatNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('123', 'Auto App', 'sjkdgkjsdbgjkbd');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Auto App',
      'Напомнить вам о поступлении новых автомобилей',
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidAllowWhileIdle: true);
}

Future<void> scheduleDailyFourAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Auto App',
      'Новые поступления!',
      _nextInstanceOfTenAM(),
      const NotificationDetails(
        android:
            AndroidNotificationDetails('123', 'Auto App', 'Auto App notify'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> schedule45MinNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Auto App',
      'Новые поступления!',
      _nextInstanceOf45Min(),
      const NotificationDetails(
        android:
            AndroidNotificationDetails('123', 'Auto App', 'Auto App notify'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

tz.TZDateTime _nextInstanceOf45Min() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, now.hour, now.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(minutes: 45));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfTenAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 16);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
