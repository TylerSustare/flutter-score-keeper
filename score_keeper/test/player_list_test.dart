import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mockito;

import 'package:score_keeper/player_list.dart';
import 'package:score_keeper/player.dart';

class Faker {
  void del({String playerName}) => print('you_spoony_bard');
}

class MockDel extends mockito.Mock implements Faker {}

void main() {
  List<Player> players = new List<Player>();

  setUp() {
    players = <Player>[
      Player(name: 'p1'),
    ]; // apparently arrays are lists
  }

  tearDown() {
    players = new List<Player>();
  }

  testWidgets('List is created with no players', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PlayerList(
        name: new List<Player>(),
        onDeletePlayer: () {},
      ),
    ));
    expect(find.byType(PlayerList), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('List is created with two players', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: PlayerList(
        name: players,
        onDeletePlayer: new Faker().del,
      ),
    ));
    expect(find.byType(PlayerList), findsOneWidget);
    expect(find.text('p1'), findsOneWidget);
    expect(find.text('p2'), findsNothing);
    tearDown();
  });

  testWidgets('Icon tap calls "onDeletePlayer"', (WidgetTester tester) async {
    setUp();
    final mock = MockDel();
    await tester.pumpWidget(MaterialApp(
      home: PlayerList(
        name: players,
        onDeletePlayer: mock.del,
      ),
    ));
    final button = find.byKey(Key('p1'));
    await tester.tap(button);
    mockito.verify(mock.del(playerName: 'p1')).called(1);
    tearDown();
  });
}
