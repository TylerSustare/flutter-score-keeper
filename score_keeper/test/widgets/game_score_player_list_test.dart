import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper/models/game.dart';
import 'package:score_keeper/widgets/game_score_player_list.dart';
import 'package:score_keeper/models/player.dart';

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
      home: GameScorePlayerList(
        game: Game(players: new List<Player>()),
      ),
    ));
    expect(find.byType( GameScorePlayerList), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('List is created with one player', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
        game: game,
      ),
    ));
    expect(find.byType( GameScorePlayerList), findsOneWidget);
    expect(find.text('p1'), findsOneWidget); // name
    expect(find.text('0'), findsOneWidget); // score
    expect(find.text('p2'), findsNothing);
    tearDown();
  });

  testWidgets('Increment the players score is reflected on the app',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
        game: game,
      ),
    ));
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    tearDown();
  });

  testWidgets('Decrementing the players score is reflected on the app',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
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
      home: GameScorePlayerList(
        game: new Game(players: players),
      ),
    ));
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    tearDown();
  });

  testWidgets('Taping edit score button brings up dialog to edit',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
        game: new Game(players: players),
      ),
    ));
    await tester.tap(find.byKey(Key('p1-edit-score')));
    await tester.pump();
    expect(find.byKey(Key('cancel-edit-score')), findsOneWidget);
    expect(find.byKey(Key('add-edit-score')), findsOneWidget);
    expect(find.byKey(Key('subtract-edit-score')), findsOneWidget);
    // close the dialog to not have a hanging animation after test is over
    await tester.tap(find.byKey(Key('cancel-edit-score')));
    await tester.pump();
    tearDown();
  });

  testWidgets('Taping edit-score add-score button adds to score',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
        game: new Game(players: players),
      ),
    ));
    expect(find.text('0'), findsOneWidget); 
    expect(find.text('11'), findsNothing); 
    await tester.tap(find.byKey(Key('p1-edit-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-edit-score')), '11');
    await tester.tap(find.byKey(Key('add-edit-score')));
    await tester.pump();
    expect(find.text('11'), findsOneWidget); 
    tearDown();
  });

    testWidgets('Taping edit-score subtract-score button removes from score',
      (WidgetTester tester) async {
    setUp();
    players[0].addScore(scoreToAdd: 100);
    await tester.pumpWidget(MaterialApp(
      home: GameScorePlayerList(
        game: new Game(players: players),
      ),
    ));
    expect(find.text('100'), findsOneWidget); 
    expect(find.text('2'), findsNothing); 
    await tester.tap(find.byKey(Key('p1-edit-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-edit-score')), '98');
    await tester.tap(find.byKey(Key('subtract-edit-score')));
    await tester.pump();
    expect(find.text('2'), findsOneWidget); 
    tearDown();
  });
}
