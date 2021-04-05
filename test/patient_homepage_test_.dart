import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/medical_records.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_search_page.dart';
import 'package:wellness24/components/pages/patient_screen/emergency_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';

void main() {
  group('Patient Home page', () {
    testWidgets('Should display list of doctors when searched',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: PatientHomePage()));
      });

      final searchBtn = find.byKey(Key('searchBtn'));

      await tester.tap(searchBtn);
      await tester.pump();

      final doctorSearchPageFinder = find.byType(DoctorSearchPage);
      expect(doctorSearchPageFinder, findsOneWidget);
    });

    testWidgets('Should be able to press emergency button',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: PatientHomePage()));
      });

      final emergencyBtn = find.byKey(Key('emergencyBtn'));

      await tester.tap(emergencyBtn);
      await tester.pump();

      final emergencyPageFinder = find.byType(EmergencyPage);
      expect(emergencyPageFinder, findsOneWidget);
    });

    testWidgets('Should be able see patients current condition',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: PatientHomePage()));
      });

      final myCurrentConditionBtn = find.byKey(Key('myCurrentConditionBtn'));

      await tester.tap(myCurrentConditionBtn);
      await tester.pump();

      final currentConditionFinder = find.byType(PatientProfile);
      expect(currentConditionFinder, findsOneWidget);
    });

    testWidgets('Should be able see patients medical records',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: PatientProfile()));
      });

      final medicalRecordsBtn = find.byKey(Key('medicalRecordsBtn'));

      await tester.tap(medicalRecordsBtn);
      await tester.pump();

      final medicalRecordsFinder = find.byType(MedicalRecords);
      expect(medicalRecordsFinder, findsOneWidget);
    });
  });
}
