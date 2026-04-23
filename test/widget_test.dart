// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bibliotaku_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('App loads and shows welcome message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We wrap BibliotakuApp in a ProviderScope because it uses Riverpod providers.
    await tester.pumpWidget(
      const ProviderScope(
        child: BibliotakuApp(),
      ),
    );

    // Verify that the welcome message is displayed.
    expect(find.text('Bienvenido a Bibliotaku'), findsOneWidget);
    expect(find.text('Tu biblioteca personal de mangas'), findsOneWidget);
  });
}
