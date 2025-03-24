import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/main.dart';
import 'package:swe_6733_group_3_adventura/createaccount.dart';

void main() {
  group('User Authentication Tests', () {
    
    // Test case for when the user tries to register with an invalid password
    testWidgets('User cannot register with an invalid password', (WidgetTester tester) async {
      // Given: The user is on the Create Account screen, ready to sign up
      await tester.pumpWidget(MaterialApp(home: CreateAccountPage()));

      // Ensure all the necessary input fields are visible on the screen
      expect(find.byType(TextField), findsNWidgets(6));

      // When: The user enters an email, an invalid password, and confirms the password
      await tester.enterText(find.byType(TextField).at(3), 'test@example.com'); // Email
      await tester.enterText(find.byType(TextField).at(4), 'password'); // Invalid password
      await tester.enterText(find.byType(TextField).at(5), 'password'); // Confirm password
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump(); // Allow time for the UI to update

      // Then: The user should see an error message about the password requirements
      expect(find.text('Password must contain at least one uppercase letter, one number, and one special character'), findsOneWidget);
    });

    // Test case for when the user enters valid login credentials
    testWidgets('User enters valid login credentials', (WidgetTester tester) async {
      // Given: The user is on the Login screen and ready to log in
      await tester.pumpWidget(MaterialApp(home: App()));

      // Check that the email and password fields are displayed
      expect(find.byType(TextField), findsNWidgets(2));

      // When: The user enters valid login credentials (email and password)
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'ValidPass123!');

      // Then: The entered credentials should be visible in the UI
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('ValidPass123!'), findsOneWidget);
    });
  });
}
