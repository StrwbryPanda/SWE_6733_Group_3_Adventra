import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/createaccount.dart';

void main() {
  testWidgets('Create Account Page Form Validation Tests', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateAccountPage()));

    // Test empty form submission
    final signUpButton = find.text('Sign Up');
    await tester.tap(signUpButton);
    await tester.pump();

    expect(find.text('Please enter your first name'), findsOneWidget);
    expect(find.text('Please enter your last name'), findsOneWidget);
    expect(find.text('Please enter a username'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please re-enter your password'), findsOneWidget);

    // Test invalid email format
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'invalid-email');
    await tester.pump();
    await tester.tap(signUpButton);
    await tester.pump();
    expect(find.text('Enter a valid email address'), findsOneWidget);

    // Test valid email format
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
    await tester.pump();
    expect(find.text('Enter a valid email address'), findsNothing);

    // Test password requirements
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'weakpassword');
    await tester.pump();
    await tester.tap(signUpButton);
    await tester.pump();
    expect(find.text('Password must contain at least one uppercase letter, one number, and one special character'), findsOneWidget);

    // Test valid password
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'StrongPass1!');
    await tester.pump();
    expect(find.text('Password must contain at least one uppercase letter, one number, and one special character'), findsNothing);

    // Test password confirmation mismatch
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'DifferentPass1!');
    await tester.pump();
    await tester.tap(signUpButton);
    await tester.pump();
    expect(find.text('The passwords do not match'), findsOneWidget);

    // Test matching passwords
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'StrongPass1!');
    await tester.pump();
    expect(find.text('The passwords do not match'), findsNothing);
  });
}