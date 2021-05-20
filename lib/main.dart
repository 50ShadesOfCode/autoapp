import 'dart:async';

import 'package:auto_app/utils/notification_service.dart';
import 'package:auto_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'components/homepage.dart';
import 'components/themeProvider.dart';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();
  await NotificationService().init();
  int? rate = await getRate();

  if (rate == 0) {
    cancelAllNotifications();
  } else if (rate == 1) {
    schedule45MinNotification();
  } else if (rate == 2) {
    repeatNotificationHourly();
  } else {
    scheduleDailyFourAMNotification();
  }

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final provider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        title: 'Flutter Demo',
        themeMode: provider.themeMode,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        home: SplashScreen(),
      );
    },
  ));
}

Future<int?> getRate() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt("rate");
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Future<String?> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("username");
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getUsername(),
        builder: (BuildContext context, AsyncSnapshot<String?> snap) {
          return Scaffold(
            body: InkWell(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/car_logo.png',
                              height: 300,
                              width: 300,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                          ],
                        )),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                if (snap.hasData)
                                  Text("Привет, " + snap.data.toString() + "!")
                                else
                                  Text("Привет!"),
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
