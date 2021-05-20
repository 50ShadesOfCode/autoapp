import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    tz.initializeTimeZones();
  }

  void showNotification() async {
    await flutterLocalNotificationsPlugin.show(
        1,
        "Auto App",
        "Новое поступление!",
        const NotificationDetails(
            android: AndroidNotificationDetails("123", "Auto App",
                'Напомнить вам о поступлении новых автомобилей')),
        payload: "kjbsdgd");
  }

  Future selectNotification(String? payload) async {}
}
