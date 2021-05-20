import 'package:auto_app/components/setupNotiChars.dart';
import 'package:auto_app/components/themeProvider.dart';
import 'package:auto_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedRate = 0;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 75,
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Введите имя пользователя'),
                      controller: _textController,
                    ),
                  ),
                  Expanded(
                      flex: 30,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_textController.text == "") {
                              return;
                            }
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString("username", _textController.text);
                            print(_textController.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Имя пользователя сохранено")));
                          },
                          child: Text("Сохранить")))
                ],
              ),
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Сменить тему"),
                    ChangeThemeButtonWidget(),
                  ],
                ),
              ),
            ),
            Container(
              child: DropdownButton<int>(
                  hint: Text("Выберите частоту уведомлений"),
                  value: selectedRate,
                  onChanged: (int? value) async {
                    setState(() {
                      selectedRate = value as int;
                    });
                    print(value);
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setInt("rate", value as int);
                    cancelAllNotifications();
                    if (value == 1) {
                      schedule45MinNotification();
                    }
                    if (value == 2) {
                      repeatNotificationHourly();
                    }
                    if (value == 3) {
                      scheduleDailyFourAMNotification();
                    }
                  },
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Не показывать уведомления",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Показывать каждые 45 минут",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Показывать каждый час",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Показывать ежедневно",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            Container(
              child: TextButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotiChars()),
                  )
                },
                child: Text("Изменить параметры уведомлений"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}

List<int> values = [0, 1, 2, 3];
