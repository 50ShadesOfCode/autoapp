import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Какой сервис вас интересует?"),
            TextButton(
              child: Text("Авто.ру"),
              onPressed: () => {},
            ),
            TextButton(
              child: Text("Автоспот"),
              onPressed: () => {},
            ),
            TextButton(
              child: Text("Вернуться назад"),
              onPressed: () => {},
            ),
            TextButton(
              child: Text("Вернуться на главный экран"),
              onPressed: () =>
                  {SystemChannels.platform.invokeMethod('SystemNavigator.pop')},
            ),
          ],
        ),
      ),
    );
  }
}
