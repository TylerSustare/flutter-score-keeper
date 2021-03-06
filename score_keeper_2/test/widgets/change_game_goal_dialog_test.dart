import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper_2/models/game.dart';
import 'package:score_keeper_2/models/theme.dart';
import 'package:score_keeper_2/widgets/game_score_player_list.dart';
import 'package:score_keeper_2/models/player.dart';

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
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: GameScorePlayerList(
          game: Game(players: new List<Player>()),
        ),
      ),
    ));
    expect(find.byType(GameScorePlayerList), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('List is created with one player', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: GameScorePlayerList(
          game: game,
        ),
      ),
    ));
    expect(find.byType(GameScorePlayerList), findsOneWidget);
    expect(find.text('p1'), findsOneWidget); // name
    expect(find.text('0'), findsOneWidget); // score
    expect(find.text('p2'), findsNothing);
    tearDown();
  });
}
