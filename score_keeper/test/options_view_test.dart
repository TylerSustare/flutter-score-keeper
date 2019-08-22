import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper/game.dart';
import 'package:score_keeper/player.dart';
import 'package:score_keeper/views/options_view.dart';

void main() {
  List<Player> players = new List<Player>();
  Game game;

  setUp() {
    players = <Player>[
      Player(name: 'p1'),
    ];

    game = new Game(players: players);
  }

  tearDown() {
    players = new List<Player>();
    game = null;
  }

  testWidgets('Options page renders', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OptionsView(
        game: Game(players: new List<Player>()),
      ),
    ));
    expect(find.byType(OptionsView), findsOneWidget);
    expect(find.text('spoon'), findsNothing);
  });

  testWidgets('Options page shows initial increment and decrement values', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: OptionsView(
        game: game,
      ),
    ));
    expect(find.text('2'), findsNWidgets(1));
    expect(find.text('1'), findsNWidgets(1));
    tearDown();
  });
}
