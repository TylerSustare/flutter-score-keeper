import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class GameTheme extends ChangeNotifier {
  Brightness brightness;
  Color color;
  bool isDark;
  bool isWakeLock;

  GameTheme({bool isDark = true, bool isWakeLock = false}) {
    this.isDark = isDark ?? true;
    this.isWakeLock = isWakeLock ?? false;
    if (this.isDark) {
      this.brightness = Brightness.dark;
      this.color = Colors.green;
    } else {
      this.brightness = Brightness.light;
      this.color = Colors.blue;
    }
    notifyListeners();
  }

  Future<void> toggleDark() async {
    this.brightness =
        this.brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    this.isDark = !this.isDark;
    this.color = this.isDark ? Colors.green : Colors.blue;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', this.isDark);

    notifyListeners();
  }

  Future<void> toggleWakeLock() async {
    this.isWakeLock = !this.isWakeLock;

    await Wakelock.toggle(on: this.isWakeLock);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isWakeLock', this.isWakeLock);

    notifyListeners();
  }
}
