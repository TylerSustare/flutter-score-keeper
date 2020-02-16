import 'package:flutter/material.dart';

class GameTheme extends ChangeNotifier {
  Brightness brightness = Brightness.dark;
  Color color = Colors.green;
  bool isDark = true;

  void toggleDark() {
    brightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    isDark = !isDark;
    color = isDark ? Colors.green : Colors.blue;
    notifyListeners();
  }
}
