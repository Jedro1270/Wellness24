import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/patient_screen/medical_histories/medical_history.dart';
import 'package:wellness24/components/pages/patient_screen/patient_emergency_contact_info.dart';
import 'package:wellness24/models/new_account.dart';

void main() {
  final lastNameField = find.byKey(Key('lastNameField'));
  final firstNameField = find.byKey(Key('lastNameField'));
  final middleInitialField = find.byKey(Key('middleInitialField'));
  final addressField = find.byKey(Key('lastNameField'));
  final relationshipField = find.byKey(Key('lastNameField'));
  final contactNumField = find.byKey(Key('contactNumField'));
  final arrowBtn = find.byType(IconButton, skipOffstage: false);

  group("Patient emergency contact info page test", () {
    testWidgets(
    'Locates widgets',

    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: EmergencyContactInfo(NewAccount('Patient')),
        ));

      expect(firstNameField, findsOneWidget);
      expect(lastNameField, findsOneWidget);
      expect(middleInitialField, findsOneWidget);
      expect(addressField, findsOneWidget);
      expect(relationshipField, findsOneWidget);
      expect(contactNumField, findsOneWidget);
      expect(arrowBtn, findsOneWidget);
      });
    });

  // testWidgets(
  // 'Should alert when a textfield is empty',
  // (WidgetTester tester) async {
  //   await tester.runAsync(() async {
  //     await tester.pumpWidget(MaterialApp(
  //       home: EmergencyContactInfo(NewAccount('Patient')),
  //     ));

  //     await tester.tap(arrowBtn);
  //     await tester.pump();

  //     final alertFinder = find.text('This field is required', skipOffstage: false);
  //     expect(alertFinder, findsNWidgets(6));
  //   });
  // });
  });
}