// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latemd/main.dart';

void main() {
  testWidgets('App loads with correct title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app title is displayed.
    expect(find.text('LateMD Lessons'), findsOneWidget);
  });

  testWidgets('Add button is present on lesson list screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that add button is present
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Search icon is present on lesson list screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that search icon is present
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
