import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:score_keeper/form.dart';
import 'package:score_keeper/player.dart';

void main() {
  testWidgets('List is created with no players', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PlayerForm(
        playerList: new List<Player>(),
        onAddPlayer: () {},
      ),
    ));
    expect(find.byType(PlayerForm), findsOneWidget);
  });
}
