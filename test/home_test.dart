// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_management_system/components/student_card.dart';
import 'package:student_management_system/pages/students_home.dart';

void main() {
  testWidgets('StudentsHome widget test', (WidgetTester tester) async {
    // Build the StudentsHome widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: StudentsHome(),
    ));

    // Verify that the SearchBar widget is present.
    expect(find.byType(SearchBar), findsOneWidget);

    // Verify that the CustomDropDown widget is not initially present.
    expect(find.byType(CustomDropDown), findsNothing);

    // Verify that the StudentCard widget is present.
    expect(find.byType(StudentCard), findsOneWidget);

    // Enter a search keyword in the SearchBar.
    await tester.enterText(find.byType(SearchBar), 'Ramith');

    // Rebuild the widget after the search keyword is entered.
    await tester.pump();
  });
}
