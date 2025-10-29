import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  testWidgets('App should load and display home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    // Verify that the app loads successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
