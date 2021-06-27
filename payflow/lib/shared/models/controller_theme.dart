import 'package:flutter/material.dart';

class ControllerTheme with ChangeNotifier {
  ControllerTheme({bool? isDarkTheme}) {
    if (isDarkTheme != null) {
      _isDarkTheme = isDarkTheme;
    }
  }
  
  var _isDarkTheme = false;
  static const key = 'isDarkTheme';

  bool get isDarkTheme => _isDarkTheme;
  set setDarkTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}