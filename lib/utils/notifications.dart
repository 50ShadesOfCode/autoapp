import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

//плагин для получения доступа к уведомлениям
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//функция для повторения уведомлений каждый час
Future<void> repeatNotificationHourly() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('123', 'Auto App', 'sjkdgkjsdbgjkbd');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  var prefs = await SharedPreferences.getInstance();
  String url = prefs.getString("noturl") as String;
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Auto App',
      await _getNotsText(url), RepeatInterval.hourly, platformChannelSpecifics,
      androidAllowWhileIdle: true);
}

//функция для повторения уведомлений ежеминутно, использовалась только для их проверки
Future<void> repeatNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('123', 'Auto App', 'sjkdgkjsdbgjkbd');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  var prefs = await SharedPreferences.getInstance();
  String url = prefs.getString("noturl") as String;
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Auto App',
      await _getNotsText(url),
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidAllowWhileIdle: true);
}

//планирует уведомление на 16.00 следующего дня
Future<void> scheduleDailyFourAMNotification() async {
  var prefs = await SharedPreferences.getInstance();
  String url = prefs.getString("noturl") as String;
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Auto App',
      await _getNotsText(url),
      _nextInstanceOfFourAM(),
      const NotificationDetails(
        android:
            AndroidNotificationDetails('123', 'Auto App', 'Auto App notify'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
  scheduleDailyFourAMNotification();
}

//планирует уведомления каждые 45 минут
Future<void> schedule45MinNotification() async {
  var prefs = await SharedPreferences.getInstance();
  String url = prefs.getString("noturl") as String;
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Auto App',
      await _getNotsText(url),
      _nextInstanceOf45Min(),
      const NotificationDetails(
        android:
            AndroidNotificationDetails('123', 'Auto App', 'Auto App notify'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
  schedule45MinNotification();
}

//выключает все уведомления
Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

//получаем следующие 45 минут просто добавляя к времени последнего уведомления 45 минут
tz.TZDateTime _nextInstanceOf45Min() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, now.hour, now.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(minutes: 45));
  }
  return scheduledDate;
}

//получаем следующие 16.00 просто добавляя к 16.00 сегодняшнего дня 1 день
tz.TZDateTime _nextInstanceOfFourAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 16);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

//получает количество автомобилей по заданным характеристикам с сервера, сравнивает с сохраненным и в зависимости от сравнения выдает текст уведомления
Future<String> _getNotsText(String url) async {
  var res = await http.post(
    Uri.parse('https://autoparseru.herokuapp.com/getNotUpdate'),
    body: json.encode({"url": url}),
    headers: headers,
  );
  var prefs = await SharedPreferences.getInstance();
  if (res.body == prefs.getString("carups")) {
    return "Новых поступлений нет!";
  } else {
    return "Новые поступления по вашим параметрам!";
  }
}

//заголовки для запроса, одинаковые в каждом файле
Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json; charset=UTF-8',
};
