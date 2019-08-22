import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:score_keeper/form.dart';
import 'package:score_keeper/player.dart';
import 'package:mockito/mockito.dart' as mockito;

class Faker {
  void add({String name}) => print('you_spoony_bard');
}

class MockAdd extends mockito.Mock implements Faker {}

void main() {
  List<Player> players = new List<Player>();

  testWidgets('Form is created', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PlayerForm(
        playerList: players,
        onAddPlayer: () {},
      ),
    ));
    expect(find.byType(PlayerForm), findsOneWidget);
  });

  testWidgets('Form can add characters', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PlayerForm(
        playerList: players,
        onAddPlayer: new Faker().add,
      ),
    ));
    await tester.enterText(find.byType(TextFormField), 'p1');
    await tester.pump();
    expect(find.text('p1'), findsOneWidget);
  });

  testWidgets('Form clears characters after adding to the game', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PlayerForm(
        playerList: players,
        onAddPlayer: new Faker().add,
      ),
    ));
    await tester.enterText(find.byType(TextFormField), 'p1');
    await tester.pump();
    expect(find.text('p1'), findsOneWidget);
    await tester.tap(find.byKey(Key('add-player-to-game')));
    await tester.pump();
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('Tests form validation', (WidgetTester tester) async{
    expect(true, false);
  }, skip: true);
}
