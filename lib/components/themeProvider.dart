import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Themes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(),
  );
}
