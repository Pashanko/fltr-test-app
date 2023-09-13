// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fltr_test_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage widget renders correctly', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(title: 'Test Title'),
      ),
    );

    // Verify that the title is displayed in the AppBar.
    expect(find.text('Test Title'), findsOneWidget);

    // Verify that the initial text is displayed on the screen.
    expect(find.text('Hello there'), findsOneWidget);

    // Verify that the initial background color is white.
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      Colors.white,
    );

    // Verify that the initial text color is black
    expect(
      tester
          .widget<Text>(
            find.text('Hello there'),
          )
          .style
          ?.color,
      Colors.black,
    );
  });

  testWidgets('Changing background color on tap', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(title: 'Test Title'),
      ),
    );

    // Record the initial background color.
    final initialBackgroundColor =
        tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor;

    // Tap on the screen to change the background color.
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pump();

    // Verify that the background color has changed.
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      isNot(equals(initialBackgroundColor)),
    );
  });
}
