// try out flutter driver at some point
// https://flutter.dev/docs/cookbook/testing/integration/introduction
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_keeper_2/main.dart';

void main() {
  testWidgets('renders wrapper', (WidgetTester tester) async {
    await tester.pumpWidget(Wrapper());
    expect(find.byIcon(Icons.autorenew), findsOneWidget);
    await tester.pump();
    await tester.pump();
    expect(find.byIcon(Icons.autorenew), findsNothing);
  });
}
