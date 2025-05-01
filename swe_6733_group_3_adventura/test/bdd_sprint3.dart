import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/home.dart';

void main() {
  testWidgets('User opens filter bottom sheet and sees filter options', (WidgetTester tester) async {
    // GIVEN the HomePage is loaded with user data
    final userData = {
      'firstname': 'Jane',
      'lastname': 'Smith',
      'email': 'jane.smith@example.com',
    };
    await tester.pumpWidget(MaterialApp(home: HomePage(userData: userData)));
    await tester.pumpAndSettle();

    // WHEN the user taps the filter button
    final filterButton = find.byIcon(Icons.filter_alt);
    expect(filterButton, findsOneWidget);
    await tester.tap(filterButton);
    await tester.pumpAndSettle();

    // THEN the bottom sheet should appear with filter options
    expect(find.text('Filter Activities'), findsOneWidget);
    expect(find.text('Filter Radius'), findsOneWidget);
  });

  testWidgets('User sees Home, Messages, and Profile buttons', (WidgetTester tester) async {
    // GIVEN the HomePage is loaded with user data
    final userData = {
      'firstname': 'Jane',
      'lastname': 'Smith',
      'email': 'jane.smith@example.com',
    };
    await tester.pumpWidget(MaterialApp(home: HomePage(userData: userData)));
    await tester.pumpAndSettle();

    // THEN the navigation buttons should be visible
    expect(find.byTooltip('Home'), findsOneWidget);       // Home button
    expect(find.byTooltip('Messages'), findsOneWidget);   // Messages button
    expect(find.byTooltip('Profile'), findsOneWidget);    // Profile button
  });
}
