// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:startup_namer/main.dart';

void main() {
  testWidgets('verify tap on heart icon', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    final heart2 = find.byKey(Key('heart_index_2'));
    final heart3 = find.byKey(Key('heart_index_3'));
    await tester.tap(heart2);
    await tester.pump();

    await tester.tap(heart3);
    await tester.pump();


    var finder = find.byWidgetPredicate((w) => w is Icon && (w.color == Colors.red));
    expect(finder, findsNWidgets(2));

    await tester.tap(heart2);
    await tester.pump();

    finder = find.byWidgetPredicate((w) => w is Icon && (w.color == Colors.red));
    expect(finder, findsOneWidget);

  });
}
