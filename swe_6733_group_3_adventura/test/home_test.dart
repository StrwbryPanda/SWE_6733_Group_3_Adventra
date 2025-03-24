import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swe_6733_group_3_adventura/home.dart';

void main() {
  testWidgets('HomePage has NavigationBar with 5 destinations', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(5));
  });

  testWidgets('Navigation destinations have correct labels', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Filter'), findsOneWidget); 
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Tapping navigation items changes current page', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());

    expect(find.text('Filter page'), findsOneWidget); // Default index is 1

    await tester.tap(find.text('Home'));
    await tester.pump();
    expect(find.text('Home page'), findsOneWidget);

    await tester.tap(find.text('Messages'));
    await tester.pump();
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Hi!'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pump();
    expect(find.text('Settings page'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(find.text('Profile page'), findsOneWidget);
  });
}