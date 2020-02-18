import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:provider/provider.dart';
import 'package:score_keeper_2/models/theme.dart';

import 'package:score_keeper_2/widgets/display_player_list.dart';
import 'package:score_keeper_2/models/player.dart';

class Faker {
  void del({String playerName}) => print('you_spoony_bard');
}

class MockDel extends mockito.Mock implements Faker {}

void main() {
  List<Player> players = new List<Player>();

  setUp() {
    players = <Player>[
      Player(name: 'p1'),
    ]; // arrays are lists
  }

  tearDown() {
    players = new List<Player>();
  }

  testWidgets('List is created with no players', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: DisplayPlayerList(
          players: new List<Player>(),
          onDeletePlayer: () {},
        ),
      ),
    ));
    expect(find.byType(DisplayPlayerList), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('List is created with two players', (WidgetTester tester) async {
    setUp();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: DisplayPlayerList(
          players: players,
          onDeletePlayer: new Faker().del,
        ),
      ),
    ));
    expect(find.byType(DisplayPlayerList), findsOneWidget);
    expect(find.text('p1'), findsOneWidget);
    expect(find.text('p2'), findsNothing);
    tearDown();
  });

  testWidgets('Icon tap brings up confirm alert ', (WidgetTester tester) async {
    setUp();
    final mock = MockDel();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: DisplayPlayerList(
          players: players,
          onDeletePlayer: mock.del,
        ),
      ),
    ));
    final deleteIcon = find.byKey(Key('p1-delete'));
    await tester.tap(deleteIcon);
    await tester.pump();
    final alert = find.text('Delete "p1" from game?');
    expect(alert, findsOneWidget);
    tearDown();
  });

  testWidgets('Icon tap and confirm tap calls "onDeletePlayer"',
      (WidgetTester tester) async {
    setUp();
    final mock = MockDel();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: DisplayPlayerList(
          players: players,
          onDeletePlayer: mock.del,
        ),
      ),
    ));
    final deleteIcon = find.byKey(Key('p1-delete'));
    await tester.tap(deleteIcon);
    await tester.pump();
    final confirmDelete = find.byKey(Key('p1-delete-confirm'));
    await tester.tap(confirmDelete);
    mockito.verify(mock.del(playerName: 'p1')).called(1);
    tearDown();
  });

  testWidgets('Icon tap and cancel tap does not call "onDeletePlayer"',
      (WidgetTester tester) async {
    setUp();
    final mock = MockDel();
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => GameTheme(),
      child: MaterialApp(
        home: DisplayPlayerList(
          players: players,
          onDeletePlayer: mock.del,
        ),
      ),
    ));
    final deleteIcon = find.byKey(Key('p1-delete'));
    await tester.tap(deleteIcon);
    await tester.pump();
    final confirmDelete = find.byKey(Key('p1-delete-cancel'));
    await tester.tap(confirmDelete);
    mockito.verifyNever(mock.del(playerName: 'p1'));
    tearDown();
  });
}
