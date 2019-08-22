import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper/main.dart';

void main() {
  testWidgets('Creates entrypoint for app', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MainApp()));
    expect(find.byType(MainApp), findsOneWidget);
    expect(find.text('p1'), findsNothing);
  });

  testWidgets('Adds one player and shows up in list',
      (WidgetTester tester) async {
    // create app
    await tester.pumpWidget(MaterialApp(home: MainApp()));
    expect(find.byType(MainApp), findsOneWidget);
    expect(find.text('p1'), findsNothing);

    // add player in form
    await tester.enterText(find.byType(TextFormField), 'p1');
    await tester.pump();
    expect(find.text('p1'), findsOneWidget);
    await tester.tap(find.byKey(Key('add-player-to-game')));
    await tester.pump();

    // find player in "PlayerList" widget
    expect(find.text('p1'), findsOneWidget);

    // switch screens
    expect(find.byKey(Key('keep-score')), findsOneWidget);
    await tester.tap(find.byKey(Key('keep-score')));
    await tester.pump();
    await tester.pump(); // two ticks of the event loop for changing screen

    // test we're on the next screen
    expect(find.text('0'), findsOneWidget); // initial score

    // test incrementing score
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    await tester.tap(find.byKey(Key('p1-increment-score')));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // test decrementing score
    await tester.tap(find.byKey(Key('p1-decrement-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);
    await tester.tap(find.byKey(Key('p1-decrement-score')));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    await tester.tap(find.byKey(Key('p1-decrement-score')));
    await tester.pump();
    expect(find.text('-1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // test reset score
    await tester.tap(find.byKey(Key('reset-game-scores')));
    await tester.pump();
    await tester.tap(find.byKey(Key('score-reset-confirm')));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);

    // test changing score by any amount
    // add
    await tester.tap(find.byKey(Key('p1-edit-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-edit-score')), '99');
    await tester.tap(find.byKey(Key('add-edit-score')));
    await tester.pump();
    expect(find.text('99'), findsOneWidget);
    expect(find.text('0'), findsNothing);
    // subtract
    await tester.tap(find.byKey(Key('p1-edit-score')));
    await tester.pump();
    await tester.enterText(find.byKey(Key('text-edit-score')), '98');
    await tester.tap(find.byKey(Key('subtract-edit-score')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('99'), findsNothing);
  });
}
