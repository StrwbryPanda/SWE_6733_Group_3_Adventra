import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/main.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('Login page has title and input fields', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Verify title is displayed
      expect(find.text('Adventra'), findsNWidgets(2));

      // Verify input fields exist
      expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    });

    testWidgets('Validation works on empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Try to submit empty form
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign in'));
      await tester.pump();

      // Verify validation messages
      expect(find.text('Please enter a username'), findsOneWidget);
      expect(find.text('Please enter a password'), findsOneWidget);
    });

    testWidgets('Shows error on invalid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Enter invalid credentials
      await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'wrong');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'wrong');
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign in'));
      await tester.pumpAndSettle();

      // Verify error message appears
      expect(find.text('Invalid username or password'), findsOneWidget);
    });

    testWidgets('Navigation buttons exist', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.widgetWithText(ElevatedButton, 'Create an Account'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Jump to Home >'), findsOneWidget);
    });
  });
}