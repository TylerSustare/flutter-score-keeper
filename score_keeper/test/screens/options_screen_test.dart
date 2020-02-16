import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:score_keeper/models/game.dart';
import 'package:score_keeper/models/player.dart';
import 'package:score_keeper/models/theme.dart';
import 'package:score_keeper/screens/options_screen.dart';

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
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: OptionsScreen(
          game: Game(players: new List<Player>()),
        ),
      ),
    ));
    expect(find.byType(OptionsScreen), findsOneWidget);
    expect(find.text('spoon'), findsNothing);
  });

  testWidgets('Options page shows initial increment and decrement values',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      // have to add a material app to this for a "context" with media query
      child: MaterialApp(
        home: OptionsScreen(
          game: game,
        ),
      ),
    ));
    expect(find.text('1'), findsNWidgets(2));
    tearDown();
  });

  testWidgets('Options page shows change dialog', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        // have to add a material app to this for a "context" with media query
        home: OptionsScreen(
          game: game,
        ),
      ),
    ));
    // incrementing score
    await tester.tap(find.byKey(Key('change-increment-score')));
    await tester.pump();
    expect(find.text('Change Value'), findsOneWidget);
    await tester.tap(find.byKey(Key('cancel-edit-inc-dec-value')));
    await tester.pump();
    expect(find.text('Change Value'), findsNothing);

    // decrementing score
    await tester.tap(find.byKey(Key('change-decrement-score')));
    await tester.pump();
    expect(find.text('Change Value'), findsOneWidget);
    await tester.tap(find.byKey(Key('cancel-edit-inc-dec-value')));
    await tester.pump();
    expect(find.text('Change Value'), findsNothing);

    expect(game.incrementValue, 1);
    expect(game.decrementValue, 1);
    tearDown();
  });

  testWidgets('Options page changes game increment and decrement values',
      (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: OptionsScreen(
          game: game,
        ),
      ),
    ));
    // incrementing score
    await tester.tap(find.byKey(Key('change-increment-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-inc-dec-value')), '10');
    await tester.tap(find.byKey(Key('edit-inc-dec-value')));
    await tester.pump();

    // decrementing score
    await tester.tap(find.byKey(Key('change-decrement-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-inc-dec-value')), '10');
    await tester.tap(find.byKey(Key('edit-inc-dec-value')));
    await tester.pump();

    expect(game.incrementValue, 10);
    expect(game.decrementValue, 10);
    tearDown();
  });
}
