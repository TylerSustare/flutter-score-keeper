import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper/game.dart';
import 'package:score_keeper/game_list.dart';
import 'package:score_keeper/player.dart';

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

  testWidgets('List is created with no players', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: GameList(
        game: Game(players: new List<Player>()),
      ),
    ));
    expect(find.byType(GameList), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('List is created with one player', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameList(
        game: game,
      ),
    ));
    expect(find.byType(GameList), findsOneWidget);
    expect(find.text('p1'), findsOneWidget); // name
    expect(find.text('0'), findsOneWidget); // score
    expect(find.text('p2'), findsNothing);
    tearDown();
  });

  testWidgets('Increment the players score is reflected on the app',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameList(
        game: game,
      ),
    ));
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    tearDown();
  });

  testWidgets('Decrementthe players score is reflected on the app',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameList(
        game: game,
      ),
    ));
    await tester.tap(find.byKey(Key('p1-decrement-score')));
    await tester.pump();
    expect(find.text('-1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    tearDown();
  });

  testWidgets('Increment one score does not impact other players',
      (WidgetTester tester) async {
    setUp();
    game.addPlayer(Player(name: 'p2'));
    await tester.pumpWidget(MaterialApp(
      home: GameList(
        game: new Game(players: players),
      ),
    ));
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    tearDown();
  });
}
