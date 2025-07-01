import 'package:flutter/material.dart';
import 'package:todo_app/theme/dark_mode.dart';
import 'package:todo_app/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isLightMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}