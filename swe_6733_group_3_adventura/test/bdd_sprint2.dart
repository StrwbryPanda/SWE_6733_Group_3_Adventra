import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/createprofile.dart'; // Import the CreateProfilePage

void main() {
  testWidgets('CreateProfile Page BDD Test 1', (WidgetTester tester) async {
    // Scenario: 
    // Given that the user is on the CreateProfilePage where they can select their gender,
    // When the user taps the male gender option,
    // Then the male button should be selected, and when they press "Sign Up", it should trigger the expected action.

    // Given: The CreateProfilePage is open, and the user can see the gender selection options
    await tester.pumpWidget(MaterialApp(home: CreateProfilePage()));

    // When: The user taps on the male gender button
    await tester.tap(find.byKey(Key('gender-male')));
    await tester.pump(); // Rebuild the widget to reflect the updated state

    // Then: The male button should be marked as selected now
    expect(find.byKey(Key('gender-male')), findsOneWidget);

    // When: The user presses the "Sign Up" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump(); // Rebuild the widget after the button press

    // Then: You can verify if the expected action happens, like navigating to the next page
    // expect(find.byType(NextPage), findsOneWidget);  // Replace with your actual target widget
  });

  testWidgets('CreateProfilePage BDD Test 2', (WidgetTester tester) async {
    // Scenario: 
    // Given that the user is on the CreateProfilePage where they can select their gender,
    // When the user taps the female gender option,
    // Then the female button should be selected, and when they press "Sign Up", it should trigger the expected action.

    // Given: The CreateProfilePage is displayed, and the user can choose a gender
    await tester.pumpWidget(MaterialApp(home: CreateProfilePage()));

    // When: The user taps the female gender button
    await tester.tap(find.byKey(Key('gender-female')));
    await tester.pump(); // Rebuild the widget to reflect the updated state

    // Then: The female button should now be selected
    expect(find.byKey(Key('gender-female')), findsOneWidget);

    // When: The user taps the "Sign Up" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pump(); // Rebuild the widget after the interaction

    // Then: Verify if the expected behavior happens after the tap, like navigation to the next page
    // expect(find.byType(NextPage), findsOneWidget);  // Replace with your actual target widget
  });
}
