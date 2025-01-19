import 'package:flutter/material.dart';
import 'package:grocery_app/themes/darkTheme.dart';
import 'package:grocery_app/themes/lightTheme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  bool get isLightMode => _themeData == lightTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
    } else {
      _themeData = darkTheme;
    }
  }
}
