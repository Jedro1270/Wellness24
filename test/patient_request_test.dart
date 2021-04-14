import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/doctor_screen/view_request_component.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

void main() {
  testWidgets(
      'ViewRequestComponent should show 2 patients from patient requests collection',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      final MockFirestoreInstance instance = MockFirestoreInstance();
      final String uid = '123';
      final DatabaseService database =
          DatabaseService(uid: uid, firestore: instance);

      List<Patient> requestPatients = [
        Patient(
            firstName: 'Jedro Vienne Deo',
            middleInitial: 'E',
            lastName: 'Pagayonan'),
        Patient(firstName: 'Veto', middleInitial: 'C', lastName: 'Bastiero')
      ];

      await tester.pumpWidget(
        MaterialApp(
            home: ViewRequest(
          database: database,
          requests: requestPatients,
        )),
      );

      expect(find.text('Jedro Vienne Deo E. Pagayonan'), findsOneWidget);
      expect(find.text('Veto C. Bastiero'), findsOneWidget);

      final requestPanels = find.byKey(Key('requestPanel'));
      expect(requestPanels, findsNWidgets(2));
    });
  });
}
