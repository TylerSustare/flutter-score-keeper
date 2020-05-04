import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper_2/models/theme.dart';

void main() {
  test('Theme constructor', () async {
    var theme = GameTheme(isDark: false);
    expect(theme.brightness, Brightness.light);
    expect(theme.color, Colors.blue);
    await theme.toggleDark();
    expect(theme.brightness, Brightness.dark);
    expect(theme.color, Colors.green);

    await theme.toggleWakeLock();
  });
}
